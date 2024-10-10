class CmsPictureCardComponent < ViewComponent::Base
  delegate :cms_colour_theme_class, to: :helpers

  def initialize(image:, title:, body_text:, colour_theme: nil, link: nil)
    @image = image
    @title = title
    @body_text = body_text
    @link = link
    @colour_theme = colour_theme
  end

  def image_classes
    classes = ["cms-picture-card__image"]
    classes << cms_colour_theme_class(@colour_theme, "bottom") if @colour_theme
    classes
  end
end
