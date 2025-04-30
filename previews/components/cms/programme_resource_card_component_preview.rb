class Cms::ProgrammeResourceCardComponentPreview < ViewComponent::Preview
  def default
    render(Cms::ProgrammeResourceCardComponent.new(
      title: "Programme card title",
      logged_out_text_content: Cms::Mocks::Text::RichBlocks.as_model,
      enrolled_text_content: Cms::Mocks::Text::RichBlocks.as_model,
      not_enrolled_text_content: Cms::Mocks::Text::RichBlocks.as_model,
      programme: Programme.i_belong
    ))
  end

  def with_color_theme
    render(Cms::ProgrammeResourceCardComponent.new(
      title: "Programme card title",
      logged_out_text_content: Cms::Mocks::Text::RichBlocks.as_model,
      enrolled_text_content: Cms::Mocks::Text::RichBlocks.as_model,
      not_enrolled_text_content: Cms::Mocks::Text::RichBlocks.as_model,
      programme: Programme.i_belong,
      color_theme: "i-belong"
    ))
  end

  def with_button
    render(Cms::ProgrammeResourceCardComponent.new(
      title: "Programme card title",
      logged_out_text_content: Cms::Mocks::Text::RichBlocks.as_model,
      enrolled_text_content: Cms::Mocks::Text::RichBlocks.as_model,
      not_enrolled_text_content: Cms::Mocks::Text::RichBlocks.as_model,
      programme: Programme.i_belong,
      button: Cms::Models::DynamicComponents::Buttons::EnrolButton.new(
        logged_out_button_text: "Log in",
        logged_in_button_text: "Click to enrol",
        programme_slug: "i-belong"
      )
    ))
  end
end
