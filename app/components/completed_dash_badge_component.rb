# frozen_string_literal: true

class CompletedDashBadgeComponent < DashBadgeComponent
  def initialize(badge_template_id:, user_id:)
    @badge_template_id = badge_template_id
    @user = User.find_by!(id: user_id)
    @issued_badge = Credly::Badge.issued_badge(@user.id, @badge_template_id)
  end

  def render?
    return false unless FeatureFlagService.new.flags[:badges_enabled]
    return false unless @issued_badge

    true
  end
end
