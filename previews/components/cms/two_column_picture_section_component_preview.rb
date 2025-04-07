class Cms::TwoColumnPictureSectionComponentPreview < ViewComponent::Preview
  layout "full-width"

  def default
    render Cms::TwoColumnPictureSectionComponent.new(
      text: Cms::Mocks::Text::RichBlocks.as_model,
      image: Cms::Mocks::Images::Image.as_model,
      image_side: "left",
      background_color: nil
    )
  end

  def right_side_image
    render Cms::TwoColumnPictureSectionComponent.new(
      text: Cms::Mocks::Text::RichBlocks.as_model,
      image: Cms::Mocks::Images::Image.as_model,
      image_side: "right",
      background_color: nil
    )
  end

  def with_background_color
    render Cms::TwoColumnPictureSectionComponent.new(
      text: Cms::Mocks::Text::RichBlocks.as_model,
      image: Cms::Mocks::Images::Image.as_model,
      image_side: "left",
      background_color: "orange"
    )
  end
end
