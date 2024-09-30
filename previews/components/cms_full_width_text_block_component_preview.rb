# frozen_string_literal: true

class CmsFullWidthTextBlockComponentPreview < ViewComponent::Preview
  def default
    render(CmsFullWidthTextBlockComponent.new)
  end
end
