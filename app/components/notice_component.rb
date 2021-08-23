# frozen_string_literal: true

class NoticeComponent < ViewComponent::Base
  include ViewComponent::Translatable

  def initialize(icon:, title:, text:, link:, class_name: nil)
    @icon = icon
    @title = title
    @text = text
    @link = link
    @tracking_category = link[:tracking_category]
    @tracking_label = link[:tracking_label]
    @class_name = class_name
  end

  def tracking_data
    return nil unless @tracking_category.present? &&
                      @tracking_label.present?

    {
      event_action: 'click',
      event_category: @tracking_category,
      event_label: @tracking_label
    }
  end
end
