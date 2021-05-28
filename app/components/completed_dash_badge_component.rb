# frozen_string_literal: true

class CompletedDashBadgeComponent < ViewComponent::Base
  def render?
    return false unless FeatureFlagService.new.flags[:badges_enabled]
  end
end
