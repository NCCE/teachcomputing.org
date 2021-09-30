class AchievementMailerPreview < ActionMailer::Preview
  def completed_face_to_face_course
    AchievementMailer.with(user_id: User.first.id).completed_face_to_face_course
  end

  def completed_online_course
    AchievementMailer.with(user_id: User.first.id).completed_online_course
  end
end
