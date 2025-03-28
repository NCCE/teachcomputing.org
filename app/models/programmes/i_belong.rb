module Programmes
  class IBelong < Programme
    PROGRAMME_TITLE = "I Belong: encouraging girls into computer science".freeze

    def certificate_name
      "I Belong"
    end

    def include_in_filter?
      false
    end

    def pending_delay
      14.days
    end

    def mailer
      IBelongMailer
    end

    def path
      i_belong_path
    end

    def enrol_path(opts = {})
      enrol_i_belong_path(opts)
    end

    def programme_title
      PROGRAMME_TITLE
    end

    def send_pending_mail?
      true
    end

    def set_user_programme_enrolment_complete_data(enrolment)
      enrolment.certificate_name = enrolment.user.school_name
      enrolment.save
    end

    def auto_enrollable?
      true
    end

    def auto_enrollment_ignored_activity_codes
      ["FD022", "CP409", "CO409"]
    end

    def minimum_character_required_community_evidence
      50
    end

    def achievement_type
      :school
    end

    def enrolment_confirmation_required?
      false
    end

    def show_extra_objectives_on_progress_bar?
      false
    end

    def certificate_path
      certificate_i_belong_path
    end
  end
end
