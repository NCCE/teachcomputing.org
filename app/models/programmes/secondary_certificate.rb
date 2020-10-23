module Programmes
  class SecondaryCertificate < Programme

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
  end
end
