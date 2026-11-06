class UpdateUserAssessmentAttemptFromClassMarkerJob < ApplicationJob
  # Sentry excludes ActiveRecord::RecordNotFound by default, including when it is the cause
  # of another error, so it is re-raised as this without a cause to make sure it's reported
  class MissingRecordError < StandardError; end

  queue_as :default

  retry_on ActiveRecord::Deadlocked, ActiveRecord::ConnectionNotEstablished, ActiveRecord::ConnectionFailed,
    wait: :polynomially_longer

  def perform(test_id, user_id, percentage)
    user = User.find(user_id)
    assessment = Assessment.find_by!(class_marker_test_id: test_id)
    latest_attempt = assessment.latest_attempt_for(user:)
    result = (percentage.to_f < assessment.required_pass_percentage) ? :failed : :passed

    unless latest_attempt.in_state?(result)
      latest_attempt.state_machine.transition_to!(result, percentage: percentage.to_f)
    end

    return if result == :failed

    if assessment.programme.cs_accelerator?
      transition_cs_accelerator(user, assessment)
    else
      CertificatePendingTransitionJob.perform_now(user, {source: "UpdateUserAssessmentAttemptFromClassMarkerJob#perform"})
    end
  rescue ActiveRecord::RecordNotFound => e
    raise MissingRecordError, e.message, e.backtrace, cause: nil
  end

  private

  def transition_cs_accelerator(user, assessment)
    achievement = user.achievements.find_by!(activity_id: assessment.activity.id)
    achievement.complete!

    # The enrolment state machine assigns the certificate number when the enrolment completes
    CSAcceleratorEnrolmentTransitionJob.perform_now(user, {source: "UpdateUserAssessmentAttemptFromClassMarkerJob#perform"})
  end
end
