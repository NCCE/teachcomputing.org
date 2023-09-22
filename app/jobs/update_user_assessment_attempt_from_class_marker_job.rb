class UpdateUserAssessmentAttemptFromClassMarkerJob < ApplicationJob
  queue_as :default

  def perform(test_id, user_id, percentage)
    user = find_user(user_id)
    assessment = find_assessment(test_id)
    achievement = find_achievement(user, assessment)
    latest_attempt = user.assessment_attempts.where(assessment_id: assessment.id).last

    if percentage.to_f >= Programmes::CSAccelerator::REQUIRED_ASSESSMENT_PERCENTAGE
      latest_attempt.transition_to(:passed, percentage: percentage.to_f)
      certificate_number = assessment.programme.programme_complete_counter.get_next_number
      achievement.complete!
      CSAcceleratorEnrolmentTransitionJob.perform_later(user, certificate_number: certificate_number)
    else
      latest_attempt.transition_to(:failed, percentage: percentage.to_f)
    end
  rescue StandardError => e
    Sentry.capture_exception(e)
  end

  private

    def find_achievement(user, assessment)
      user.achievements.where(activity_id: assessment.activity.id).first
    end

    def find_assessment(test_id)
      Assessment.find_by!(class_marker_test_id: test_id)
    end

    def find_user(user_id)
      User.find(user_id)
    end
end
