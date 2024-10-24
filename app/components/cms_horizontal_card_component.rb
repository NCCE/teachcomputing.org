# frozen_string_literal: true

class CmsHorizontalCardComponent < ViewComponent::Base
  delegate :cms_color_theme_class, to: :helpers

  def initialize(title:, body_blocks:, image: nil, image_link: nil, color_theme: nil, icon_block: nil, spacing: nil)
    @title = title
    @body_blocks = body_blocks
    @image = image
    @image_link = image_link
    @color_theme = color_theme
    @icon_block = icon_block
    @spacing = spacing&.downcase
  end

  def padding
    if @spacing == "first"
      {bottom: 3, top: 7}
    elsif @spacing == "last"
      {bottom: 7, top: 3}
    else
      {}
    end
  end

  def wrapper_classes
    classes = ["horizontal-card-component__wrapper"]
    classes << cms_color_theme_class(@color_theme, "left") if @color_theme
    classes
  end
end
