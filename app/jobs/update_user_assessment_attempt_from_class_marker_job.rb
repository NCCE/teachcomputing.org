class UpdateUserAssessmentAttemptFromClassMarkerJob < ApplicationJob
  queue_as :default

  def perform(test_id, result)
    begin
      @user = find_user(result[:email])
      @assessment = find_assessment(test_id)
      @achievement = find_achievement
      latest_attempt = @user.assessment_attempts.where(assessment_id: @assessment.id).last

      if result[:percentage].to_f >= 65.0
        latest_attempt.transition_to(:passed, percentage: result[:percentage].to_f)
        @achievement.set_to_complete
      else
        latest_attempt.transition_to(:failed, percentage: result[:percentage].to_f)
      end
    rescue StandardError => e
      Raven.capture_exception(e)
    end
  end

  private
    def find_achievement
      @user.achievements.where(activity_id: @assessment.activity.id).first
    end

    def find_assessment(test_id)
      Assessment.find_by!(class_marker_test_id: test_id)
    end

    def find_user(email)
      User.find_by!(email: email)
    end
end
