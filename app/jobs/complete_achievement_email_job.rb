class CompleteAchievementEmailJob < ApplicationJob
  queue_as :default

  def perform(user, activity)
    completed_community_achievement_count = user.achievements.joins(:activity).where(activity: { category: Activity::COMMUNITY_CATEGORY }).count

    if completed_community_achievement_count.zero?
      user
        .user_programme_enrolments
        .where(programme: [Programme.primary_certificate, Programme.secondary_certificate])
        .in_state(:enrolled)
    end
  end
end
