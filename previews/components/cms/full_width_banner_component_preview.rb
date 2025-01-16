# frozen_string_literal: true

class Cms::FullWidthBannerComponentPreview < ViewComponent::Preview
  def default
    render(Cms::FullWidthBannerComponent.new(
      text_content: Cms::Mocks::RichBlocks.generate,
      background_color: :white,
      image: Cms::Mocks::Image.as_model,
      image_side: :left,
      image_link: nil,
      buttons: []
    ))
  end

  def with_button
    render(Cms::FullWidthBannerComponent.new(
      text_content: Cms::Mocks::RichBlocks.generate,
      background_color: :white,
      image: Cms::Mocks::Image.as_model,
      image_side: :left,
      image_link: nil,
      buttons: [Cms::Mocks::NcceButton.as_model]
    ))
  end
end
