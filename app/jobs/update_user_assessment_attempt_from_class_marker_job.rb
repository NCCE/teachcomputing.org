class UpdateUserAssessmentAttemptFromClassMarkerJob < ApplicationJob
  queue_as :default

  def perform(test_id, user_id, percentage)
    user = User.find(user_id)
    assessment = Assessment.find_by!(class_marker_test_id: test_id)
    latest_attempt = assessment.latest_attempt_for(user:)

    return latest_attempt.transition_to(:failed, percentage: percentage.to_f) if percentage.to_f < assessment.required_assessment_percentage

    latest_attempt.transition_to(:passed, percentage: percentage.to_f)

    if assessment.programme.cs_accelerator?
      transition_cs_accelerator(user, assessment, programme)
    else
      CertificatePendingTransitionJob.perform_now(user, { source: 'UpdateUserAssessmentAttemptFromClassMarkerJob#perform' })
    end
  rescue StandardError => e
    Sentry.capture_exception(e)
  end

  private

  def transition_cs_accelerator(user, assessment)
    achievement = user.achievements.find_by(activity_id: assessment.activity.id)
    achievement.complete!

    certificate_number = assessment.programme.programme_complete_counter.get_next_number
    CSAcceleratorEnrolmentTransitionJob.perform_now(user, certificate_number: certificate_number)
  end
end
