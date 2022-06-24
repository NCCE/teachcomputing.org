module FutureLearn
  class UpdateUserActivityJob < ApplicationJob
    queue_as :default

    def perform(course_uuid:, enrolment:)
      user = User.find_by(
        '? = ANY (future_learn_organisation_memberships)',
        enrolment[:organisation_membership][:uuid]
      )

      activity = Activity.find_by(future_learn_course_uuid: course_uuid)

      achievement = fetch_achievement(activity_id: activity.id, user_id: user.id)
      return if achievement.complete?

      achievement.update_progress_and_state(
        enrolment[:steps_completed_ratio].to_f * 100,
        enrolment[:deactivated_at]
      )

      queue_cert_transition_job(achievement.programme, user.id) if needs_cert_transition_job?(achievement)

      queue_assessment_eligibility_job(user.id) if needs_assessment_eligibility_job?(achievement)
    end

    private

      def fetch_achievement(activity_id:, user_id:)
        Achievement.find_or_create_by(activity_id: activity_id, user_id: user_id)
      end

      def needs_cert_transition_job?(achievement)
        (achievement.primary_certificate? || achievement.secondary_certificate?) && achievement.complete?
      end

      def queue_cert_transition_job(programme, user_id)
        CertificatePendingTransitionJob.set(wait: 1.minute).perform_later(
          programme,
          user_id,
          source: 'FutureLearn::UpdateUserActivityJob'
        )
      end

      def needs_assessment_eligibility_job?(achievement)
        achievement.cs_accelerator? && achievement.complete?
      end

      def queue_assessment_eligibility_job(user_id)
        AssessmentEligibilityJob.perform_later(user_id)
      end
  end
end
