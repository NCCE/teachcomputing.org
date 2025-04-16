class Cms::TwoColumnVideoSectionComponentPreview < ViewComponent::Preview
  layout "full-width"

  def default
    render Cms::TwoColumnVideoSectionComponent.new(
      left_column_content: Cms::Mocks::Text::RichBlocks.as_model,
      video_side: "right",
      video: Cms::Mocks::DynamicComponents::ContentBlocks::EmbeddedVideo.as_model
    )
  end

  def with_right_column_content
    render Cms::TwoColumnVideoSectionComponent.new(
      left_column_content: Cms::Mocks::Text::RichBlocks.as_model,
      video_side: "right",
      video: Cms::Mocks::DynamicComponents::ContentBlocks::EmbeddedVideo.as_model,
      right_column_content: Cms::Mocks::Text::RichBlocks.as_model
    )
  end

  def with_right_column_content_with_left_video
    render Cms::TwoColumnVideoSectionComponent.new(
      left_column_content: Cms::Mocks::Text::RichBlocks.as_model,
      video_side: "left",
      video: Cms::Mocks::DynamicComponents::ContentBlocks::EmbeddedVideo.as_model,
      right_column_content: Cms::Mocks::Text::RichBlocks.as_model
    )
  end

  def with_background_color
    render Cms::TwoColumnVideoSectionComponent.new(
      left_column_content: Cms::Mocks::Text::RichBlocks.as_model,
      video_side: "right",
      video: Cms::Mocks::DynamicComponents::ContentBlocks::EmbeddedVideo.as_model,
      background_color: "isaac"
    )
  end

  def with_button
    render Cms::TwoColumnVideoSectionComponent.new(
      left_column_content: Cms::Mocks::Text::RichBlocks.as_model,
      video: Cms::Mocks::DynamicComponents::ContentBlocks::EmbeddedVideo.as_model,
      video_side: "right",
      left_column_button: Cms::Mocks::DynamicComponents::Buttons::NcceButton.as_model
    )
  end

  def with_content_background_color
    render Cms::TwoColumnVideoSectionComponent.new(
      left_column_content: Cms::Mocks::Text::RichBlocks.as_model,
      video_side: "right",
      video: Cms::Mocks::DynamicComponents::ContentBlocks::EmbeddedVideo.as_model,
      left_column_button: Cms::Mocks::DynamicComponents::Buttons::NcceButton.as_model,
      background_color: "isaac",
      box_color: "white"
    )
  end

  def with_section_title
    render Cms::TwoColumnVideoSectionComponent.new(
      left_column_content: Cms::Mocks::Text::RichBlocks.as_model,
      video: Cms::Mocks::DynamicComponents::ContentBlocks::EmbeddedVideo.as_model,
      left_column_button: Cms::Mocks::DynamicComponents::Buttons::NcceButton.as_model,
      background_color: "isaac",
      box_color: "white",
      video_side: "right",
      section_title: Cms::Mocks::DynamicComponents::EmbedBlocks::SectionTitle.as_model(title: "Section title")
    )
  end
end
