# frozen_string_literal: true

class Cms::FullWidthImageBannerComponentPreview < ViewComponent::Preview
  def default
    render(Cms::FullWidthImageBannerComponent.new(
      overlay_title: Faker::Lorem.sentence,
      background_image: Cms::Mocks::Images::Image.as_model,
      overlay_icon: Cms::Mocks::Images::Image.as_model,
      overlay_text: Cms::Mocks::Text::RichBlocks.as_model,
      overlay_side: "right"
    ))
  end
end
