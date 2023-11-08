module Programmes
  class IBelong < Programme
    PROGRAMME_TITLE = 'I Belong: encouraging girls into computer science'.freeze

    def short_name
      'I belong'
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
  end
end
