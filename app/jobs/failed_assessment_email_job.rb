class FailedAssessmentEmailJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    # To be enabled once email content received
    # AssessmentMailer.with(user_id: user_id).failed.deliver_now
  end
end
