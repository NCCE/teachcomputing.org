# frozen_string_literal: true

class Cms::SideBannerComponentPreview < ViewComponent::Preview
  def default
    render(Cms::SideBannerComponent.new(text_content: "text_content", icon: "icon", banner_color: "banner_color"))
  end
end
