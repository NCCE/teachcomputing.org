module Programmes
  class CSAccelerator < Programme
    PROGRAMME_TITLE = "GCSE Computer Science Subject Knowledge".freeze

    def certificate_name
      "KS3 and GCSE subject knowledge certificate"
    end

    def pending_delay
      7.days
    end

    def mailer
      CSAcceleratorMailer
    end

    def enough_credits_for_test?(user)
      complete_achievements = user.achievements
        .belonging_to_programme(self)
        .in_state("complete")

      # Allow legacy users with two face to face take test
      total_face_to_face = complete_achievements.with_category("face-to-face").sum(:credit)
      return true if total_face_to_face >= 20

      total_credits = complete_achievements.sum(:credit)
      return true if total_credits >= 30

      false
    end

    def show_notification_for_test?(user)
      enrolment = user.user_programme_enrolments.find_by(programme_id: id)
      return false if enrolment.nil? || enrolment.in_state?(:complete, :unenrolled)

      enough_credits_for_test?(user)
    end

    def notification_link
      cs_accelerator_certificate_path
    end

    def diagnostic
      activities.find_by!(category: "diagnostic")
    end

    def path
      cs_accelerator_certificate_path
    end

    def enrol_path(opts = {})
      enrol_cs_accelerator_certificate_path(opts)
    end

    def programme_title
      PROGRAMME_TITLE
    end

    def bcs_logo
      "media/images/logos/subject-knowledge-bcs.svg"
    end

    def course_achievements(user)
      user.achievements.includes(:activity)
        .belonging_to_programme(self)
        .with_category([Activity::FACE_TO_FACE_CATEGORY,
          Activity::ONLINE_CATEGORY])
        .not_in_state(:dropped)
        .order(:created_at)
    end

    def auto_enrollable?
      true
    end

    def programme_objectives
      [
        ProgrammeObjectives::AssessmentPassRequired.new(
          assessment: Assessment.find_by(programme: self)
        )
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
      certificate_cs_accelerator_certificate_path
    end
  end
end
