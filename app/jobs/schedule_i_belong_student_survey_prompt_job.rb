class ScheduleIBelongStudentSurveyPromptJob < ApplicationJob
  queue_as :default

  def perform(user)
    IBelongMailer.with(user: user).student_attitude_surveys.deliver_now
  end
end
