# frozen_string_literal: true

class BannerComponent < ViewComponent::Base
  def initialize(title:, text:, image:, background_color:, link:, image_side: :left)
    @title = title
    @text = text
    @image = image
    @background_color = background_color
    @image_side = image_side
    @link = link
  end

  def image_side_class
    "image-#{@image_side}"
  end
end
