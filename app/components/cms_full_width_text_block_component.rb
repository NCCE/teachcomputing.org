# frozen_string_literal: true

class CmsFullWidthTextBlockComponent < ViewComponent::Base
  def initialize(blocks:, background_color:)
    @blocks = blocks
    @background_color = background_color
  end

  def wrapper_classes
    classes = ["cms-full-width-text-row"]
    classes << "#{@background_color}-bg" if @background_color
    classes
  end
end
