class CmsResourceCardComponent < ViewComponent::Base
  def initialize(title:, icon:, colour_theme:, body_text:)
    @title = title
    @icon = icon
    @colour_theme = colour_theme
    @body_text = body_text
  end
end
