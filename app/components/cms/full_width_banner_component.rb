# frozen_string_literal: true

class Cms::FullWidthBannerComponent < ViewComponent::Base
  delegate :cms_image, to: :helpers

  def initialize(text_content:, image:, image_side:, image_link:, title:, background_color: nil, buttons: [], show_bottom_border: false)
    @text_content = text_content
    @image = image
    @image_side = image_side
    @image_link = image_link
    @title = title
    @background_color = background_color
    @buttons = buttons
    @show_bottom_border = show_bottom_border
  end

  def wrapper_classes
    classes = ["cms-full-width-banner-row"]
    classes << "#{@background_color}-bg" if @background_color
    classes << "has-border" if @show_bottom_border
    classes
  end

  def banner_classes
    classes = ["cms-full-width-banner"]
    classes << "right-align" if @image_side == "right"
    classes
  end
end
