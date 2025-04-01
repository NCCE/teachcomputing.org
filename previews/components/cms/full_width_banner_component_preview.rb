# frozen_string_literal: true

class Cms::FullWidthBannerComponentPreview < ViewComponent::Preview
  def default
    render(Cms::FullWidthBannerComponent.new(
      text_content: Cms::Mocks::TextComponents::RichBlocks.as_model,
      title: "Banner title",
      background_color: :white,
      image: Cms::Mocks::ImageComponents::Image.as_model,
      image_side: "left",
      image_link: nil,
      buttons: []
    ))
  end

  def with_button
    render(Cms::FullWidthBannerComponent.new(
      title: "Banner title",
      text_content: Cms::Mocks::TextComponents::RichBlocks.as_model,
      background_color: :white,
      image: Cms::Mocks::ImageComponents::Image.as_model,
      image_side: "left",
      image_link: nil,
      buttons: [Cms::Mocks::DynamicComponents::Buttons::NcceButton.as_model]
    ))
  end

  def with_i_belong_flag
    render(Cms::FullWidthBannerComponent.new(
      title: "Banner title",
      text_content: Cms::Mocks::TextComponents::RichBlocks.as_model,
      background_color: :white,
      image: Cms::Mocks::ImageComponents::Image.as_model,
      image_side: "right",
      image_link: nil,
      buttons: [Cms::Mocks::DynamicComponents::Buttons::NcceButton.as_model],
      i_belong_flag: true
    ))
  end

  def with_corner_flourish
    render(Cms::FullWidthBannerComponent.new(
      title: "Banner title",
      text_content: Cms::Mocks::TextComponents::RichBlocks.as_model,
      background_color: :white,
      image: Cms::Mocks::ImageComponents::Image.as_model,
      image_side: "left",
      image_link: nil,
      buttons: [Cms::Mocks::DynamicComponents::Buttons::NcceButton.as_model],
      corner_flourish: true
    ))
  end
end
