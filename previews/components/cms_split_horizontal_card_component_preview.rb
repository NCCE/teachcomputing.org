# frozen_string_literal: true

class CmsSplitHorizontialCardComponentPreview < ViewComponent::Preview
  def default
    render(CmsSplitHorizontialCardComponent.new(
      section_title: Faker::Lorem.sentence,
      card_content: Cms::Mocks::RichBlocks.as_model,
      aside_content: Cms::Mocks::RichBlocks.as_model,
      aside_icon: Cms::Mocks::Image.as_model,
      aside_title: "aside_title",
      background_color: "light-grey",
      color_theme: "standard"
    ))
  end
end