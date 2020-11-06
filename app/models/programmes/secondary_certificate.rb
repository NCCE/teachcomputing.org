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

    def user_completed_diagnostic?(_user)
      false
    end

    def user_is_eligible?(user)
      programme = Programme.find_by(slug: 'cs-accelerator')
      enrolment = UserProgrammeEnrolment.find_by(user_id: user.id, programme_id: programme.id)
      enrolment.current_state == :complete.to_s
    end


    def user_meets_completion_requirement?(user)
      completed_group_count = 0
      programme_activity_groupings.each do |group|
        completed_group_count += 1 if group.user_complete?(user)
      end

      return true if completed_group_count == programme_activity_groupings.count
    end 
    
    def path
    end
  end
end
