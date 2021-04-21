module Credly
  class IssueBadgeJob < ApplicationJob
    queue_as :default

    def perform(user_id, programme_id)
      return unless FeatureFlagService.new.flags[:badge_enabled]

      badge_template_id = Programme.find(programme_id).credly_badge_template_id
      user = User.find(user_id)

      issued_badges = Credly::Badges.issued(user.id, badge_template_id)

      return if issued_badges.map { |badge| badge[:badge_template][:id] == badge_template_id }.any?

      Credly::Badge.issue(user.id, badge_template_id)
      # send email
    end
  end
end
