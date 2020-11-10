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
        next unless known_organisation_membership_uuids.include?(membership_id)

        membership_has_multiple_ids = known_multiple_id_memberships.any? do |m|
          m.include?(membership_id)
        end

        if membership_has_multiple_ids
          users_memberships = known_multiple_id_memberships.select do |x|
            x.include?(membership_id)
          end.first

          users_memberships.delete(membership_id)

          other_enrolments = user_enrolments.select { |m, _e| users_memberships.include?(m) }

          other_enrolments.each do |other_membership_id, other_membership_enrolments|
            enrolments += other_membership_enrolments
            user_enrolments.delete(other_membership_id)
          end

        end

        latest_enrolment = enrolments.sort do |a, b|
          DateTime.parse(a[:activated_at]) <=> DateTime.parse(b[:activated_at])
        end.reverse.first

        FutureLearn::UpdateUserActivityJob.perform_later(
          course_uuid: course_uuid,
          enrolment: latest_enrolment
        )
      end
    end

    private

      def known_organisation_membership_uuids
        @known_organisation_membership_uuids ||= begin
          User.pluck(:future_learn_organisation_memberships).flatten.compact
        end
      end

      def known_multiple_id_memberships
        @known_multiple_id_memberships ||= begin
          User.pluck(:future_learn_organisation_memberships).select { |memberships| memberships.length > 1 }
        end
      end
  end
end
