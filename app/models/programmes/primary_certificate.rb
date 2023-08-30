module Programmes
  class PrimaryCertificate < Programme
    PROGRAMME_TITLE = 'Primary Computing Teaching'.freeze

    def mailer
      PrimaryMailer
    end

    def path
      primary_certificate_path
    end

    def public_path
      primary_path
    end

    def enrol_path(opts = {})
      enrol_primary_certificate_path(opts)
    end

    def programme_title
      PROGRAMME_TITLE
    end

    def bcs_logo
      'media/images/logos/primary-bcs.svg'
    end

    def pathways?
      true
    end

    def enrichment_enabled?
      true
    end
  end
end
