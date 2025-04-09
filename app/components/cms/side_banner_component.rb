# frozen_string_literal: true

class Cms::SideBannerComponent < ViewComponent::Base
  def initialize(text_content:, icon:, banner_color: nil, side: "right")
    @text_content = text_content
    @icon = icon
    @banner_color = banner_color
    @side = side
  end

  def wrapper_classes
    classes = ["cms-side-banner", "cms-side-banner--#{@side}"]
    classes << if @banner_color
      "#{@banner_color}-bg"
    else
      "white-bg"
    end
    classes
  end

  def content_classes
    ["cms-side-banner__content", "cms-side-banner__content--#{@side}"]
  end
end
