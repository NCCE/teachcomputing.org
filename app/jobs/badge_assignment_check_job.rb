class BadgeAssignmentCheckJob < ApplicationJob
  queue_as :default

  def perform(days_to_check: 31, programmes_to_check: [])
    missing_badges = []
    programmes_to_check.each do |programme|
      recent_achievements = Achievement.in_state(:complete)
        .belonging_to_programme(programme)
        .where(most_recent_achievement_transition: {updated_at: days_to_check.days.ago..})
      badge = programme.badges.active.first

      if badge
        recent_achievements.includes(:user).find_each do |achievement|
          user = achievement.user

          next unless programme.user_qualifies_for_credly_badge?(user)
          next if user_has_badge?(user, programme)

          missing_badges << [user, programme]
        end
      end
    end

    missing_badges
  end

  private

  def user_has_badge?(user, programme)
    Credly::Badge.by_programme_badge_template_ids(user.id, programme.badges.pluck(:credly_badge_template_id)).present?
  end
end
