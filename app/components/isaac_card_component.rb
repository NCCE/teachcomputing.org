# frozen_string_literal: true

class IsaacCardComponent < ViewComponent::Base
  include ViewComponent::Translatable

  def initialize(tracking_category: nil, padding_class: nil)
    @tracking_category = tracking_category
    @padding_class = padding_class
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
