class CheckNextStepsJob < ApplicationJob
  queue_as :default

  def perform(achievement)
    user = User.find(achievement.user_id)

    AchievementMailer.with(user: user).completed_face_to_face_course.deliver_now if achievement.activity.category == ONLINE_CATEGORY

    AchievementMailer.with(user: user).completed_online_course.deliver_now if achievement.activity.category == FACE_TO_FACE_CATEGORY
  end
end
