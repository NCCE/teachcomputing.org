# frozen_string_literal: true

class DashBadgeComponent < ViewComponent::Base
  def initialize(achievement:, badge_template_id:, user_id:)
    @achievement = achievement
    @badge_template_id = badge_template_id
    @user = User.find_by!(id: user_id)
    @issued_badge = Credly::Badge.by_badge_template_id(@user.id, @badge_template_id)
  end

  def render?
    return false unless FeatureFlagService.new.flags[:badges_enabled]
    return false unless @issued_badge

    @achievement.complete?
  end

  def badge_image_url
    @issued_badge[:badge_template][:image_url]
  end

  def badge_url
    if @issued_badge[:state]
      @issued_badge[:accept_badge_url]
    else
      @issued_badge[:url]
    end
  end
end
