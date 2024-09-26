# frozen_string_literal: true

class CmsFullWidthBannerComponent < ViewComponent::Base
  delegate :cms_image, to: :helpers

  def initialize(text_content:, image:, image_side:, image_link:, title:, background_color: nil, buttons: [])
    @text_content = text_content
    @image = image
    @image_side = image_side
    @image_link = image_link
    @title = title
    @background_color = background_color
    @buttons = buttons
  end

  def wrapper_classes
    classes = []
    classes << "#{@background_color}-bg" if @background_color
    classes
  end

  def banner_classes
    classes = ["cms-full-width-banner"]
    classes << "right-align" if @image_side == "right"
    classes
  end
end
