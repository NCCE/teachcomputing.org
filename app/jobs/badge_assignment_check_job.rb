class BadgeAssignmentCheck < ApplicationJob
  queue_as :default

  def perform(days_to_check: 31)
    users_with_recent_achievements = User.joins(:achievements).merge(Achievement.in_state(:complete))
      .where("most_recent_achievement_transition.updated_at": days_to_check.days.ago..).distinct

    missing_badges = []
    users_with_recent_achievements.each do |user|
      user.user_programme_enrolments.each do |user_programme_enrolment|
        programme = user_programme_enrolment.programme
        badge = programme.badges.active.first

        next unless badge
        next unless programme.badgeable?
        next unless programme.user_qualifies_for_credly_badge?(user)
        has_badge = user_has_badge?(user, programme)

        if !has_badge
          missing_badges << [user.email, programme.title]
        end
      end
    end

    recent_achievements = Achievement.in_state(:complete).where("most_recent_achievement_transition.updated_at": days_to_check.days.ago..)

    missing_badges = []
    recent_achievements.each do |achievement|
      achievement.activity.programmes.each do |programme|
        user = achievement.user
        badge = programme.badges.active.first

        next unless badge
        next unless programme.badgeable?
        next unless programme.user_qualifies_for_credly_badge?(user)
        has_badge = user_has_badge?(user, programme)

        if !has_badge
          missing_badges << [user.email, programme.title]
        end
      end
    end

    missing_badges
  end

  private

  def user_has_badge?(user, programme)
    Credly::Badge.by_programme_badge_template_ids(user.id, programme.badges.pluck(:credly_badge_template_id))
  end
end
