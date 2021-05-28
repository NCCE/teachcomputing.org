# frozen_string_literal: true

class DashBadgeComponent < ViewComponent::Base
  def initialize(achievement:)
    @achievement = achievement
  end

  def render?
    return false unless FeatureFlagService.new.flags[:badges_enabled]
    @achievement.complete?
  end
end
