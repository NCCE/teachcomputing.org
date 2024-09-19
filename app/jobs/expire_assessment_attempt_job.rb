class ExpireAssessmentAttemptJob < ApplicationJob
  queue_as :default

  def perform(assessment_attempt)
    assessment_attempt.transition_to(:timed_out)
  end
end
