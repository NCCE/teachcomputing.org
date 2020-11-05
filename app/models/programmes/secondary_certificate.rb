module Programmes
  class SecondaryCertificate < Programme
    def csa_eligible_courses(user)
      enrolment = UserProgrammeEnrolment.find_by(user_id: user.id, programme_id: Programme.cs_accelerator.id)
      return unless enrolment

      courses = user.achievements.for_programme(Programme.cs_accelerator).where('created_at > ?', enrolment.completed_at?)
    end

    def diagnostic
      false
    end

    def user_completed_diagnostic?(user)
      false
    end

    def user_is_eligible?(user)
      programme = Programme.find_by(slug: 'cs-accelerator')
      enrolment = UserProgrammeEnrolment.find_by(user_id: user.id, programme_id: programme.id)
      enrolment.current_state == :complete.to_s
    end

    def user_meets_completion_requirement?(user)
      groups_completed_count = 0
      programme_activity_groupings.each do |group|
          complete_requirement = group.required_for_completion
          compelted_activity_count = 0
          group.programme_activities.each do |programme_activity|
              completed_activity = user.achievements.in_state(:complete).for_programme(self).where(activity_id: programme_activity.activity.id).any?
              compelted_activity_count = compelted_activity_count + 1 if completed_activity
              groups_completed_count = groups_completed_count + 1 if compelted_activity_count >= complete_requirement
              break if compelted_activity_count >= complete_requirement
          end
        end

        return true if groups_completed_count == programme_activity_groupings.count
    end
  end
end
