module Programmes
  class PrimaryCertificate < Programme
    PROGRAMME_TITLE = "Teach Primary Computing".freeze

    def certificate_name
      "Teach primary computing certificate"
    end

    def pending_delay
      7.days
    end

    def mailer
      PrimaryMailer
    end

    def path
      primary_certificate_path
    end

    def public_path
      cms_page_path("primary-certificate")
    end

    def enrol_path(opts = {})
      enrol_primary_certificate_path(opts)
    end

    def programme_title
      PROGRAMME_TITLE
    end

    def bcs_logo
      "media/images/logos/primary-bcs.svg"
    end

    def pathways?
      true
    end

    def send_pending_mail?
      true
    end

    def auto_enrollable?
      true
    end

    def achievement_type
      :individual
    end

    def enrolment_confirmation_required?
      true
    end

    def certificate_path
      certificate_primary_certificate_path
    end
  end
end
