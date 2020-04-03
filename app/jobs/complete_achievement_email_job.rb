class CompleteAchievementEmailJob < ApplicationJob
  queue_as :default

  def perform(user_id, activity_id)
    # To be enabled once email content received
    # AchievementMailer.with(user_id: user_id, activity_id: activity_id).complete.deliver_now
  end
end
