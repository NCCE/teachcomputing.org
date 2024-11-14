# frozen_string_literal: true

class CmsSplitHorizontalCardComponent < ViewComponent::Base
  delegate :cms_color_theme_class, to: :helpers

  def initialize(card_content:, aside_content:, aside_icon: nil, aside_title: nil, section_title: nil, color_theme: nil, background_color: nil)
    @card_content = card_content
    @aside_content = aside_content
    @aside_icon = aside_icon
    @aside_title = aside_title
    @section_title = section_title
    @color_theme = color_theme
    @background_color = background_color
  end

  def wrapper_classes
    classes = ["cms-split-horizontal-card"]
    classes << "#{@background_color}-bg" if @background_color
    classes
  end

  def left_card_classes
    classes = ["split-horizontal-card"]
    classes << cms_color_theme_class(@color_theme, "left") if @color_theme
    classes
  end
end
