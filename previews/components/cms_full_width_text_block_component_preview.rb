# frozen_string_literal: true

class CmsFullWidthTextBlockComponentPreview < ViewComponent::Preview
  def default
    render(CmsFullWidthTextBlockComponent.new(
      blocks: Cms::Mocks::RichBlocks.as_model
    ))
  end
end
