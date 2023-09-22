module Programmes
  class SecondaryCertificate < Programme
    PROGRAMME_TITLE = 'Secondary Computing Teaching'.freeze

    def mailer
      SecondaryMailer
    end

    def user_meets_completion_requirement?(user)
      return false unless Programme.cs_accelerator.user_completed?(user)

      super(user)
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

    def enrichment_enabled?
      true
    end
  end
end
