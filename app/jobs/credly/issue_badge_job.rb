module Credly
  class IssueBadgeJob < ApplicationJob
    queue_as :default

    def perform(user_id, programme_id)
      return unless FeatureFlagService.new.flags[:badges_enabled]

      programme = Programme.find(programme_id)
      badge = programme.badges.active.first
      user = User.find(user_id)
      issued_badges = Credly::Badge.issued(user.id)

      return if issued_badges.map { |badge| badge[:badge_template][:id] == badge.credly_badge_template_id }.any?

      Credly::Badge.issue(user.id, badge.credly_badge_template_id)
      NewBadgeMailer.new_badge_email(user, programme).deliver_now
    end
  end
end
