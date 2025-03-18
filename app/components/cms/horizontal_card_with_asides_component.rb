# frozen_string_literal: true

class Cms::HorizontalCardWithAsidesComponent < Cms::WithAsidesComponent
  delegate :cms_color_theme_class, to: :helpers

  def initialize(text:, aside_sections:, button: nil, background_color: nil, color_theme: nil)
    super(aside_sections:)
    @text = text
    @button = button
    @background_color = background_color
    @color_theme = color_theme
  end

  def wrapper_classes
    classes = ["horizontal-card-with-asides-component__wrapper white-bg"]
    classes << cms_color_theme_class(@color_theme, "left") if @color_theme
    classes
  end
end
