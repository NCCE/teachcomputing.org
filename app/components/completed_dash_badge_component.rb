# frozen_string_literal: true

class CompletedDashBadgeComponent < SecondaryDashBadgeComponent
  def initialize(badge_template_id:, user_id:, tracking_event_category: nil, tracking_event_label: nil)
    @badge_template_id = badge_template_id
    @user = User.find_by!(id: user_id)
    @tracking_event_category = tracking_event_category
    @tracking_event_label = tracking_event_label
    @issued_badge = Credly::Badge.by_badge_template_id(@user.id, @badge_template_id)
  end

  def render?
    return false unless FeatureFlagService.new.flags[:badges_enabled]
    return false unless @issued_badge

    true
  end

  def tracking_data
    return nil unless @tracking_event_category.present? &&
                      @tracking_event_label.present?

    {
      event_action: 'click',
      event_category: @tracking_event_category,
      event_label: @tracking_event_label
    }
  end
end
