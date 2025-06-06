module Programmes
  class ALevel < Programme
    PROGRAMME_TITLE = "A level subject knowledge".freeze

    def certificate_name
      "A Level subject knowledge certificate"
    end

    def include_in_filter?
      false
    end

    def mailer
      ALevelMailer
    end

    def path
      a_level_path
    end

    def enrol_path(opts = {})
      enrol_a_level_path(opts)
    end

    def programme_title
      PROGRAMME_TITLE
    end

    def programme_objectives
      [
        ProgrammeObjectives::AssessmentPassRequired.new(
          assessment: Assessment.find_by(programme: self)
        ),
        *programme_activity_groupings.includes(:programme_activities).order(:sort_key)
      ]
    end

    def achievement_type
      :individual
    end

    def enrolment_confirmation_required?
      false
    end

    def show_extra_objectives_on_progress_bar?
      false
    end

    def certificate_path
      certificate_a_level_path
    end
  end
end
