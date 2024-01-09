# frozen_string_literal: true

class ActivityComponent < ViewComponent::Base
  def initialize(objective:, button:, description: nil, tracking_category: nil, class_name: nil)
    @objective = objective
    @description = description
    @button = button
    @tracking_category = tracking_category
    @class_name = class_name
  end

  def tracking_data(label)
    return nil unless @tracking_category.present? && label.present?

    {
      event_action: "click",
      event_category: @tracking_category,
      event_label: label
    }
  end
end
