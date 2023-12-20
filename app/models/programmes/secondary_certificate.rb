module Programmes
  class SecondaryCertificate < Programme
    PROGRAMME_TITLE = 'Teach Secondary Computing'.freeze

    def short_name
      'Secondary certificate'
    end

    def pending_delay
      7.days
    end

    def mailer
      SecondaryMailer
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

    def programme_objectives
      [
        ProgrammeObjectives::ProgrammeCompletionRequired.new(
          required_programme: Programme.cs_accelerator,
          progress_bar_title: 'Complete the Secondary subject knowledge',
          progress_bar_path: cs_accelerator_path
        ),
        *programme_activity_groupings.includes(:programme_activities).order(:sort_key)
      ]
    end

    def send_pending_mail?
      true
    end
  end
end
