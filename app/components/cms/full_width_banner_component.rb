# frozen_string_literal: true

class Cms::FullWidthBannerComponent < ViewComponent::Base
  delegate :cms_image, to: :helpers

  def initialize(text_content:, image:, image_side:, image_link:, title:, background_color: nil, box_color: nil, buttons: [], show_bottom_border: false, i_belong_flag: false, corner_flourish: false, image_fit: "cover")
    @text_content = text_content
    @image = image
    @image_side = image_side
    @image_link = image_link
    @title = title
    @background_color = background_color
    @box_color = box_color.presence || "white"
    @buttons = buttons
    @show_bottom_border = show_bottom_border
    @i_belong_flag = i_belong_flag
    @corner_flourish = corner_flourish
    @image_fit = image_fit
  end

  def box_classes
    ["cms-full-width-banner__content"]
  end

  def wrapper_classes
    classes = ["cms-full-width-banner-row"]
    classes << "#{@background_color}-bg" if @background_color
    classes << "has-border" if @show_bottom_border
    classes
  end

  def banner_classes
    classes = ["cms-full-width-banner", "#{@box_color}-bg"]
    classes << "right-align" if @image_side == "right"
    classes
  end
end
