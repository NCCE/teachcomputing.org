class FailedAssessmentEmailJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    AssessmentMailer.with(user_id: user_id).failed.deliver_now
  end
end
