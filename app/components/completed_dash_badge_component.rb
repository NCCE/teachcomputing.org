# frozen_string_literal: true

class CompletedDashBadgeComponent < ViewComponent::Base
  def initialize(badge:, tracking_event_category: nil, tracking_event_label: nil)
    @badge = badge
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
