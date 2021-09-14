# frozen_string_literal: true

class AsideComponent < ViewComponent::Base
  def initialize(text:, title: nil, link: nil, **options)
    @title = title
    @text = text
    @link = link
    @image = options[:image]
    @tracking_category = options[:tracking_category]
  end

  def tracking_data(label = nil)
    return nil unless @tracking_category.present? && label.present?

    {
      event_action: 'click',
      event_category: @tracking_category,
      event_label: label
    }
  end
end
