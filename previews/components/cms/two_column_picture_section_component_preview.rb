class Cms::TwoColumnPictureSectionComponentPreview < ViewComponent::Preview
  layout "full-width"

  def default
    render Cms::TwoColumnPictureSectionComponent.new(
      text: Cms::Mocks::Text::RichBlocks.as_model,
      image: Cms::Mocks::Images::Image.as_model,
      image_side: "left",
      banner: nil,
      background_color: nil
    )
  end

  def right_side_image
    render Cms::TwoColumnPictureSectionComponent.new(
      text: Cms::Mocks::Text::RichBlocks.as_model,
      image: Cms::Mocks::Images::Image.as_model,
      image_side: "right",
      banner: nil,
      background_color: nil
    )
  end

  def with_background_color
    render Cms::TwoColumnPictureSectionComponent.new(
      text: Cms::Mocks::Text::RichBlocks.as_model,
      image: Cms::Mocks::Images::Image.as_model,
      image_side: "left",
      banner: nil,
      background_color: "orange"
    )
  end

  def with_section_title
    render Cms::TwoColumnPictureSectionComponent.new(
      text: Cms::Mocks::Text::RichBlocks.as_model,
      image: Cms::Mocks::Images::Image.as_model,
      image_side: "left",
      background_color: "orange",
      banner: nil,
      section_title: Cms::Mocks::DynamicComponents::EmbedBlocks::SectionTitle.as_model(title: "Section title")
    )
  end

  def with_banner_left
    render Cms::TwoColumnPictureSectionComponent.new(
      text: Cms::Mocks::Text::RichBlocks.as_model,
      image: Cms::Mocks::Images::Image.as_model,
      image_side: "right",
      background_color: nil,
      banner: Cms::Mocks::DynamicComponents::EmbedBlocks::SideBanner.as_model,
      section_title: nil
    )
  end

  def with_banner_right
    render Cms::TwoColumnPictureSectionComponent.new(
      text: Cms::Mocks::Text::RichBlocks.as_model,
      image: Cms::Mocks::Images::Image.as_model,
      image_side: "left",
      background_color: nil,
      banner: Cms::Mocks::DynamicComponents::EmbedBlocks::SideBanner.as_model,
      section_title: nil
    )
  end
end
