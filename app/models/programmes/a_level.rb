module Programmes
  class ALevel < Programme
    PROGRAMME_TITLE = "A level subject knowledge".freeze

    def certificate_name
      "A Level subject knowledge certificate"
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

    def user_qualifies_for_credly_badge?(user)
      user_enrolled?(user) && user_meets_completion_requirement?(user)
    end
  end
end
