class Cms::TwoColumnVideoSectionComponentPreview < ViewComponent::Preview
  layout "full-width"

  def default
    render Cms::TwoColumnVideoSectionComponent.new(
      left_column_content: Cms::Mocks::RichBlocks.as_model,
      video: Cms::Mocks::DynamicComponents::ContentBlocks::EmbeddedVideo.as_model
    )
  end

  def with_right_column_content
    render Cms::TwoColumnVideoSectionComponent.new(
      left_column_content: Cms::Mocks::RichBlocks.as_model,
      video: Cms::Mocks::DynamicComponents::ContentBlocks::EmbeddedVideo.as_model,
      right_column_content: Cms::Mocks::RichBlocks.as_model
    )
  end

  def with_background_color
    render Cms::TwoColumnVideoSectionComponent.new(
      left_column_content: Cms::Mocks::RichBlocks.as_model,
      video: Cms::Mocks::DynamicComponents::ContentBlocks::EmbeddedVideo.as_model,
      background_color: "isaac"
    )
  end

  def with_button
    render Cms::TwoColumnVideoSectionComponent.new(
      left_column_content: Cms::Mocks::RichBlocks.as_model,
      video: Cms::Mocks::DynamicComponents::ContentBlocks::EmbeddedVideo.as_model,
      left_column_button: Cms::Mocks::DynamicComponents::Buttons::NcceButton.as_model
    )
  end

  def with_content_background_color
    render Cms::TwoColumnVideoSectionComponent.new(
      left_column_content: Cms::Mocks::RichBlocks.as_model,
      video: CmCms::Mocks::DynamicComponents::ContentBlocks::EmbeddedVideo.as_model,
      left_column_button: Cms::Mocks::DynamicComponents::Buttons::NcceButton.as_model,
      background_color: "isaac",
      box_color: "white"
    )
  end
end
