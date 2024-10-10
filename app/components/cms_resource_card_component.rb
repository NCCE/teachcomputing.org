class CmsResourceCardComponent < ViewComponent::Base
  delegate :cms_colour_theme_class, to: :helpers

  def initialize(title:, body_text:, icon: nil, colour_theme: nil, button_text: nil, button_link: nil)
    @title = title
    @icon = icon
    @colour_theme = colour_theme
    @body_text = body_text
    @button_text = button_text
    @button_link = button_link
  end

  def wrapper_classes
    classes = ["cms-resource-card"]
    classes << cms_colour_theme_class(@colour_theme, "top") if @colour_theme
    classes
  end
end
