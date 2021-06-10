# frozen_string_literal: true

class CSAcceleratorDashBadgeComponent < PrimarySecondaryDashBadgeComponent
  def initialize(achievement:, badge_template_id:, user_id:, tracking_event_category: nil, tracking_event_label: nil)
    @achievement = achievement
    @badge_template_id = badge_template_id
    @user = User.find_by!(id: user_id)
    @tracking_event_category = tracking_event_category
    @tracking_event_label = tracking_event_label
    @issued_badge = Credly::Badge.by_badge_template_id(@user.id, @badge_template_id)
  end
end
