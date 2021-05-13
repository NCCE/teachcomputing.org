# frozen_string_literal: true

class HeroImageComponent < ViewComponent::Base
  def initialize(title:, text:, image_url:, image_title:, class_name: nil)
    @class_name = class_name
    @title = title
    @text = text
    @image_url = image_url
    @image_title = image_title
  end
end
