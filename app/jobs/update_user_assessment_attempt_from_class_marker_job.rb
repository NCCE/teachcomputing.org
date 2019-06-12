class UpdateUserAssessmentAttemptFromClassMarkerJob < ApplicationJob
  queue_as :default

  def perform(test_id, email, percentage)
    begin
      user = find_user(email)
      assessment = find_assessment(test_id)
      achievement = find_achievement(user, assessment)
      latest_attempt = user.assessment_attempts.where(assessment_id: assessment.id).last

      if percentage.to_f >= 65.0
        latest_attempt.transition_to(:passed, percentage: percentage.to_f)
        certificate_index = assessment.assessment_attempts.passed_attempts_with_user
                                      .map(&:user_id).index(user.id)
        achievement.set_to_complete(certificate_index: certificate_index)
      else
        latest_attempt.transition_to(:failed, percentage: percentage.to_f)
      end
    rescue StandardError => e
      Raven.capture_exception(e)
    end
  end

  private

    def find_achievement(user, assessment)
      user.achievements.where(activity_id: assessment.activity.id).first
    end

    def find_assessment(test_id)
      Assessment.find_by!(class_marker_test_id: test_id)
    end

    def find_user(email)
      User.find_by!(email: email)
    end
end
