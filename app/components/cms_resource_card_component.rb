class CmsResourceCardComponent < ViewComponent::Base
  delegate :cms_colour_theme_class, to: :helpers

  def initialize(title:, icon:, colour_theme:, body_text:, button_text:, button_link:)
    @title = title
    @icon = icon
    @colour_theme = colour_theme
    @body_text = body_text
    @button_text = button_text
    @button_link = button_link
  end

  def wrapper_classes
    classes = ["cms-resource-card_wrapper"]
    classes << cms_colour_theme_class(@colour_theme, "top", 8) if @colour_theme
    classes
  end
end
