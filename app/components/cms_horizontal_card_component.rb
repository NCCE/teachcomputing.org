# frozen_string_literal: true

class CmsHorizontalCardComponent < ViewComponent::Base
  def initialize(title:, body_blocks:, image:, image_link:, colour_theme:, icon_block:)
    @title = title
    @body_blocks = body_blocks
    @image = image
    @image_link = image_link
    @colour_theme = colour_theme
    @icon_block = icon_block
  end
end
