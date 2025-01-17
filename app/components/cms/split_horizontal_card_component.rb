# frozen_string_literal: true

class Cms::SplitHorizontalCardComponent < ViewComponent::Base
  delegate :cms_color_theme_class, to: :helpers

  def initialize(card_content:, aside_content:, aside_icon: nil, aside_title: nil, section_title: nil, color_theme: nil, background_color: nil)
    @card_content = card_content
    @section_title = section_title
    @color_theme = color_theme
    @background_color = background_color
    @aside_content = aside_content
    @aside_icon = aside_icon
    @aside_title = aside_title
  end
end
