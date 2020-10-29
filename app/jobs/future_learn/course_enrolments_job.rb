module FutureLearn
  class CourseEnrolmentsJob < ApplicationJob
    queue_as :default

    def perform(course_uuid:, run_uuids:)
      all_enrolments = []
      run_uuids.each do |run_uuid|
        all_enrolments += FutureLearn::Queries::CourseEnrolments.all(run_uuid)
      end

      user_enrolments = Hash.new { |h, k| h[k] = [] }
      all_enrolments.each { |e| user_enrolments[e[:organisation_membership][:uuid]] << e }
      user_enrolments.each do |membership_id, enrolments|
        latest_enrolment = enrolments.sort do |a, b|
          DateTime.parse(a[:activated_at]) <=> DateTime.parse(b[:activated_at])
        end.reverse.first

        if known_organisation_membership_uuids.include?(membership_id)
          FutureLearn::UpdateUserActivityJob.perform_later(
            course_uuid: course_uuid,
            enrolment: latest_enrolment
          )
        else
          FutureLearn::UserInformationJob.perform_later(
            course_uuid: course_uuid,
            enrolment: latest_enrolment
          )
        end
      end
    end

    private

      def known_organisation_membership_uuids
        @known_organisation_membership_uuids ||= begin
          User.pluck(:future_learn_organisation_memberships).flatten.compact
        end
      end
  end
end
