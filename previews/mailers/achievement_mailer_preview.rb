class AchievementMailerPreview < ActionMailer::Preview
  def complete__disabled
    AchievementMailer.with(user_id: User.first.id, activity_id: Activity.first.id, preview: true).complete
  end

  def completed_course
    AchievementMailer.with(user_id: User.first.id, preview: true).completed_course
  end
end
