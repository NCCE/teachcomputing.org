# frozen_string_literal: true

class NoticeComponent < ViewComponent::Base
  include ViewComponent::Translatable

  def initialize(icon:, title:, text:, link:, tracking_category: nil, class_name: nil)
    @icon = icon
    @title = title
    @text = text
    @link = link
    @class_name = class_name
    @tracking_category = tracking_category
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
