# frozen_string_literal: true

class Cms::SplitHorizontalCardWrapperComponent < ViewComponent::Base
  delegate :cms_color_theme_class, to: :helpers

  renders_one :aside_card_content
  renders_one :aside

  def initialize(card_content:, section_title: nil, color_theme: nil, background_color: nil)
    @card_content = card_content
    @section_title = section_title
    @color_theme = color_theme
    @background_color = background_color
  end

  def wrapper_classes
    classes = ["cms-split-horizontal-card-wrapper"]
    classes << "#{@background_color}-bg" if @background_color
    classes
  end

  def left_card_classes
    classes = ["split-horizontal-card white-bg"]
    classes << cms_color_theme_class(@color_theme, "left") if @color_theme
    classes
  end
end
