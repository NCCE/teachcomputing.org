# frozen_string_literal: true

class CmsFullWidthBannerComponent < ViewComponent::Base
  delegate :cms_image, to: :helpers

  def initialize(text_content:, image:, image_side:, image_link:, background_color: :white, buttons: [])
    @text_content = text_content
    @image = image
    @image_side = image_side
    @image_link = image_link
    @background_color = background_color
    @buttons = buttons
  end

  def banner_classes
    ["#{@background_color}-bg"]
  end
end
