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

    def credits_achieved_for_certificate(user)
      complete_achievements = user.achievements
        .belonging_to_programme(self)
        .in_state("complete")

      total = 0

      total_face_to_face = complete_achievements.with_category("face-to-face").sum(:credit)
      return 100 if total_face_to_face >= 20

      total = 50 if total_face_to_face >= 10

      total_online = [complete_achievements.with_category("online").sum(:credit), 20].min.to_i
      total += total_online / 20 * 50

      total
    end

    def enough_activities_for_test?(user)
      complete_achievements = user.achievements
        .belonging_to_programme(self)
        .in_state("complete")

      total_face_to_face = complete_achievements.with_category("face-to-face").sum(:credit)
      return true if total_face_to_face >= 20

      total_online = complete_achievements.with_category("online").sum(:credit)
      return true if total_face_to_face >= 10 && total_online >= 20

      false
    end

    def show_notification_for_test?(user)
      enrolment = user.user_programme_enrolments.find_by(programme_id: id)
      return false if enrolment.nil? || enrolment.in_state?(:complete, :unenrolled)

      return false unless in_notifiable_period?(user)

      enough_activities_for_test?(user)
    end

    def in_notifiable_period?(user)
      enrolment = user.user_programme_enrolments.find_by(programme_id: id)
      notifiable_date_range = 48.hours.ago..Time.current

      notifiable_date_range.cover?(enrolment.last_enrolled_at)
    end

    def notification_link
      cs_accelerator_certificate_path
    end

    def max_credits_for_certificate
      100
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

    def compulsory_achievement(user)
      achievements = user
        .achievements
        .belonging_to_programme(self)
        .with_category(Activity::FACE_TO_FACE_CATEGORY)
        .not_in_state(:dropped)
        .order(:created_at)

      complete = achievements.select { |ach| ach.in_state?(:complete) }
      return complete.min_by { |x| x.last_transition.created_at } if complete.present?

      achievements.first
    end

    def non_compulsory_achievements(user)
      user.achievements.belonging_to_programme(self)
        .with_category([Activity::FACE_TO_FACE_CATEGORY,
          Activity::ONLINE_CATEGORY])
        .where.not(id: compulsory_achievement(user)&.id)
        .not_in_state(:dropped)
    end

    def user_completed_non_compulsory_achievement?(user)
      non_compulsory_achievements(user).any? { |a| a.complete? }
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

    def certificate_path
      certificate_cs_accelerator_certificate_path
    end
  end
end
