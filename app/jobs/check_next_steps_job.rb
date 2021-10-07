class CheckNextStepsJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find(user_id)

    case achievement.activity.category
    when 'online'
      AchievementMailer.with(user_id: user.id).completed_online_course.deliver_now
    when 'face-to-face'
      AchievementMailer.with(user_id: user.id).completed_face_to_face_course.deliver_now
    end
  end
end
