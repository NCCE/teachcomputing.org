class IssueBadgeJob
  queue_as :default

  def perform(achievement_id)
    achievement = Achievement.find(achievement_id)
    achievement.issue_badge
  end
end
