class ScheduleUserResourcesFeedbackJob < ApplicationJob
  queue_as :default
  
  def perform(user, year)
    ResourcesFeedbackMailer.with(user: user, year: year).feedback_request
  end
end
