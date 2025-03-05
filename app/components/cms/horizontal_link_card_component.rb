# frozen_string_literal: true

class Cms::HorizontalLinkCardComponent < ViewComponent::Base
  delegate :cms_color_theme_class, to: :helpers

  def initialize(title:, link_url:, card_content:, theme:)
    @title = title
    @link_url = link_url
    @card_content = card_content
    @theme = theme
  end

  def wrapper_classes
    classes = ["cms-horizontal-link-card white-bg"]
    if @theme
      classes << cms_color_theme_class(@theme, "left")
      classes << "#{@theme}-theme"
    end
    classes
  end
end
