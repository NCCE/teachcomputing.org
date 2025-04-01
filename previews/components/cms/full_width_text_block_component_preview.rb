# frozen_string_literal: true

class Cms::FullWidthTextBlockComponentPreview < ViewComponent::Preview
  def default
    render(Cms::FullWidthTextBlockComponent.new(
      blocks: Cms::Mocks::TextComponents::RichBlocks.as_model,
      background_color: nil,
      show_bottom_border: false
    ))
  end
end
