module Programmes
  class SecondaryCertificate < Programme
    PROGRAMME_TITLE = 'Secondary Computing Teaching'.freeze
    def csa_eligible_courses(user)
      enrolment = UserProgrammeEnrolment.find_by(user_id: user.id, programme_id: Programme.cs_accelerator.id)
      return unless enrolment

      achievements = user.achievements.for_programme(Programme.cs_accelerator).in_state(:complete)
      achievements.filter do |achievement|
        achievement.last_transition.created_at > enrolment.completed_at?
      end
    end

    def diagnostic
      false
    end

    def user_completed_diagnostic?(_user)
      false
    end

    def user_is_eligible?(user)
      programme = Programme.find_by(slug: 'cs-accelerator')
      enrolment = UserProgrammeEnrolment.find_by(user_id: user&.id, programme_id: programme.id)
      enrolment&.current_state == :complete.to_s
    end

    def user_meets_completion_requirement?(user)
      programme_activity_groupings.all? { |group| group.user_complete?(user) }
    end

    def path
      secondary_certificate_path
    end

    def enrol_path(opts = {})
      enrol_secondary_certificate_path(opts)
    end

    def programme_title
      PROGRAMME_TITLE
    end
  end
end
