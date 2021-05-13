# frozen_string_literal: true

class PageCardComponent < ViewComponent::Base
  def initialize(title:, text:, link_title:, link_url:, class_name: nil, image_url: nil)
    @class_name = class_name
    @image_url = image_url
    @title = title
    @text = text
    @link_title = link_title
    @link_url = link_url
  end
end
