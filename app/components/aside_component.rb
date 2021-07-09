# frozen_string_literal: true

class AsideComponent < ViewComponent::Base
  def initialize(title:, text:, link_text:, link_url:, **options)
    @title = title
    @text = text
    @link_text = link_text
    @link_url = link_url
    @tracking_category = options[:tracking_category]
    @tracking_label = options[:tracking_label]
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
