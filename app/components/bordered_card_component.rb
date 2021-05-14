# frozen_string_literal: true

class BorderedCardComponent < ViewComponent::Base
  def initialize(
    title:, text:, link_title:, link_url:,
    tracking_page: nil, tracking_label: nil, class_name: nil, image_url: nil
  )
    @title = title
    @text = text
    @link_title = link_title
    @link_url = link_url
    @tracking_page = tracking_page
    @tracking_label = tracking_label
    @class_name = class_name
    @image_url = image_url
  end
end
