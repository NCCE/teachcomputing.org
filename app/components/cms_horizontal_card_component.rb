# frozen_string_literal: true

class CmsHorizontalCardComponent < ViewComponent::Base
  delegate :cms_colour_theme_class, to: :helpers

  def initialize(title:, body_blocks:, image: nil, image_link: nil, colour_theme: nil, icon_block: nil)
    @title = title
    @body_blocks = body_blocks
    @image = image
    @image_link = image_link
    @colour_theme = colour_theme
    @icon_block = icon_block
  end

  def wrapper_classes
    classes = ["horizontal-card-component__wrapper"]
    classes << cms_colour_theme_class(@colour_theme, "left") if @colour_theme
    classes
  end
end
