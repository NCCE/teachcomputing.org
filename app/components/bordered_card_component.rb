# frozen_string_literal: true

class BorderedCardComponent < ViewComponent::Base
  def initialize(title:, text:, link_title:, link_url:, class_name: nil, image_url: nil)
    @title = title
    @text = text
    @link_title = link_title
    @link_url = link_url
    @class_name = class_name
    @image_url = image_url
  end
end
