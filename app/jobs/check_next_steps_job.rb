class CheckNextStepsJob < ApplicationJob
  queue_as :default

  def perform(achievement)
    user = User.find(achievement.user_id)

    case achievement.activity.category
    when 'online'
      AchievementMailer.with(user_id: user.id).completed_online_course.deliver_now
    when 'face-to-face'
      AchievementMailer.with(user_id: user.id).completed_face_to_face_course.deliver_now
    end
  end
end
