class Cms::ResourceCardComponent < ViewComponent::Base
  delegate :cms_color_theme_class, to: :helpers

  def initialize(title:, body_text:, icon: nil, color_theme: nil, button_text: nil, button_link: nil)
    @title = title
    @icon = icon
    @color_theme = color_theme
    @body_text = body_text
    @button_text = button_text
    @button_link = button_link
  end

  def wrapper_classes
    classes = ["cms-resource-card", "white-bg"]
    classes << cms_color_theme_class(@color_theme, "top") if @color_theme
    classes
  end
end
