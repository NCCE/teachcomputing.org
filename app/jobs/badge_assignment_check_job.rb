class BadgeAssignmentCheck < ApplicationJob
  queue_as :default

  def perform(days_to_check: 31)
    recent_achievements = Achievement.in_state(:complete).where("most_recent_achievement_transition.updated_at": days_to_check.days.ago..)

    missing_badges = []
    recent_achievements.each do |achievement|
      achievement.activity.programmes.each do |programme|
        user = achievement.user
        badge = programme.badges.active.first

        next unless badge
        next unless programme.badgeable?
        next unless programme.user_qualifies_for_credly_badge?(user)
        next if user_has_badge?(user, programme)

        missing_badges << [user, programme]
      end
    end

    missing_badges
  end

  private

  def user_has_badge?(user, programme)
    Credly::Badge.by_programme_badge_template_ids(user.id, programme.badges.pluck(:credly_badge_template_id))
  end
end
