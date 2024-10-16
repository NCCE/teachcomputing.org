class CmsPictureCardComponent < ViewComponent::Base
  delegate :cms_color_theme_class, to: :helpers

  def initialize(image:, title:, body_text:, color_theme: nil, link: nil)
    @image = image
    @title = title
    @body_text = body_text
    @link = link
    @color_theme = color_theme
  end

  def image_classes
    classes = ["cms-picture-card__image"]
    classes << cms_color_theme_class(@color_theme, "bottom") if @color_theme
    classes
  end
end
