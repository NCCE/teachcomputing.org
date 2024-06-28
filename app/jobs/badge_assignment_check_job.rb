# This job is used for debugging to check if there are any outstanding badges for a given programme, it will not assign badges, just returns list of missing
class BadgeAssignmentCheckJob < ApplicationJob
  queue_as :default

  def perform(programmes_to_check, days_to_check: 31)
    programmes_to_check.each_with_object([]) do |programme, missing_badges|
      next unless programme.badges.active.any?
      recent_achievements = Achievement.in_state(:complete)
        .belonging_to_programme(programme)
        .where(most_recent_achievement_transition: {updated_at: days_to_check.days.ago..})

      recent_achievements.includes(:user).find_each do |achievement|
        user = achievement.user

        next unless programme.user_qualifies_for_credly_cpd_badge?(user)
        next if user_has_badge?(user, programme)

        missing_badges << [user, programme]
      end
    end
  end

  private

  def user_has_badge?(user, programme)
    Credly::Badge.by_programme_badge_template_ids(user.id, programme.badges.cpd.pluck(:credly_badge_template_id)).present?
  end
end
