class FailedAssessmentEmailJob < ApplicationJob
  queue_as :default

  def perform(assessment_attempt)
    AssessmentMailer.with(user: assessment_attempt.user_id).failed.deliver_now
  end
end
