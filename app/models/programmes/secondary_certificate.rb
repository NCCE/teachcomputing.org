module Programmes
  class SecondaryCertificate < Programme
    PROGRAMME_TITLE = 'Secondary Computing Teaching'.freeze

    def mailer
      SecondaryMailer
    end

    def user_is_eligible?(user)
      programme = Programme.find_by(slug: 'cs-accelerator')
      enrolment = UserProgrammeEnrolment.find_by(user_id: user&.id, programme_id: programme.id)
      enrolment&.current_state == :complete.to_s
    end

    def csa_eligible_courses(user)
      programme = Programme.cs_accelerator
      enrolment = UserProgrammeEnrolment.find_by(user_id: user.id, programme_id: programme.id)
      return unless enrolment

      achievements = user.achievements.for_programme(programme).in_state(:complete)
      achievements.filter do |achievement|
        achievement.last_transition.created_at > enrolment.completed_at?
      end
    end

    def path
      secondary_certificate_path
    end

    def public_path
      secondary_path
    end

    def enrol_path(opts = {})
      enrol_secondary_certificate_path(opts)
    end

    def programme_title
      PROGRAMME_TITLE
    end

    def bcs_logo
      'media/images/logos/secondary-bcs.svg'
    end

    def pathways?
      true
    end
  end
end
