module FutureLearn
  class UpdateOrganisationMembershipsJob < ApplicationJob
    queue_as :default

    def perform
      course_runs = FutureLearn::Queries::CourseRuns.all

      course_run_ids_hash = Hash.new { |h, k| h[k] = [] }
      course_runs.each { |r| course_run_ids_hash[r[:course][:uuid]] << r[:uuid] }

      tc_course_ids = Activity.all.pluck(:future_learn_course_uuid).compact
      known_membership_ids = User.pluck(:future_learn_organisation_memberships)
                                 .flatten
                                 .compact

      course_run_ids_hash.each do |course_id, run_uuids|
        unless tc_course_ids.include?(course_id)
          title = course_runs.select { |r| r[:course][:uuid] == course_id }.first[:title]
          report_missing_course(course_id, title)
          next
        end

        run_uuids.each do |run_uuid|
          retries ||= 0
          enrolments = FutureLearn::Queries::CourseEnrolments.all(run_uuid)
          membership_ids = enrolments.map { |e| e[:organisation_membership][:uuid] }.uniq

          membership_ids.each do |membership_id|
            next if known_membership_ids.include?(membership_id)

            FutureLearn::UserInformationJob.perform_later(membership_id: membership_id)

            # add the membership to the array we check against so we don't
            # queue another update job for it
            known_membership_ids << membership_id
          end
        rescue Faraday::UnauthorizedError => e
          retry if (retries += 1) < 3
          Sentry.capture_message(
            'UnauthorizedError checking course enrolments',
            extra: { error: e, run_uuid: run_uuid }
          )
        end
      end
    end

    private

      def report_missing_course(course_id, title)
        return if FL_PARTNERS_IGNORED_COURSE_UUIDS.include?(course_id)

        Sentry.capture_message(
          'FutureLearn course not found during progress update checking',
          extra: { course_id: course_id, course_title: title }
        )
      end
  end
end
