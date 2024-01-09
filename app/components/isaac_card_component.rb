# frozen_string_literal: true

class IsaacCardComponent < ViewComponent::Base
  include ViewComponent::Translatable

  def initialize(tracking_category: nil)
    @tracking_category = tracking_category
  end

  def tracking_data(tracking_label)
    return nil if @tracking_category.blank?

    {
      event_action: "click",
      event_category: @tracking_category,
      event_label: tracking_label
    }
  end
end
