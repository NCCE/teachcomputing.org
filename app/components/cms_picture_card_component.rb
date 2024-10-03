class CmsPictureCardComponent < ViewComponent::Base
  delegate :cms_colour_theme_class, to: :helpers

  def initialize(image:, title:, body_text:, link:, colour_theme:)
    @image = image
    @title = title
    @body_text = body_text
    @link = link
    @colour_theme = colour_theme
  end

  def ribbon_class
    cms_colour_theme_class(@colour_theme, "bottom") if @colour_theme
  end
end
