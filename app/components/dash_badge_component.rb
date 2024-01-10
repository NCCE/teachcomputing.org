# frozen_string_literal: true

class DashBadgeComponent < ViewComponent::Base
  def initialize(badge:, fixed_width: false, tracking_event_category: nil, tracking_event_label: nil)
    @badge = badge
    @fixed_width = fixed_width
    @tracking_event_category = tracking_event_category
    @tracking_event_label = tracking_event_label
  end

  def render?
    @badge.present?
  end

  def tracking_data
    return nil unless @tracking_event_category.present? &&
      @tracking_event_label.present?

    {
      event_action: "click",
      event_category: @tracking_event_category,
      event_label: @tracking_event_label
    }
  end
end
