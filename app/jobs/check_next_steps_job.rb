class CheckNextStepsJob < ApplicationJob
  queue_as :default

  def perform(user_id, activity_id)
    #user = User.find(user_id)
    # AchievementMailer.with(user_id: user_id, activity_id: activity_id).completed_face_to_face_course.deliver_now
    # AchievementMailer.with(user_id: user_id, activity_id: activity_id).completed_online_course.deliver_now
  end
end
