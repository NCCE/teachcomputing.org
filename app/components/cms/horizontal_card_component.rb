# frozen_string_literal: true

class Cms::HorizontalCardComponent < ViewComponent::Base
  delegate :cms_color_theme_class, to: :helpers

  def initialize(title:, body_blocks:, image: nil, image_link: nil, color_theme: nil, icon_block: nil, spacing: nil, external_title: nil, background_color: nil)
    @title = title
    @body_blocks = body_blocks
    @image = image
    @image_link = image_link
    @color_theme = color_theme
    @icon_block = icon_block
    @spacing = spacing&.downcase
    @external_title = external_title
    @background_color = background_color
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
    if @color_theme
      classes << cms_color_theme_class(@color_theme, "left")
      classes << "#{@color_theme}-theme"
    end
    classes
  end
end
