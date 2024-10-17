# frozen_string_literal: true

class CmsFullWidthTextBlockComponent < ViewComponent::Base
  def initialize(blocks:, background_color:, show_bottom_border:)
    @blocks = blocks
    @background_color = background_color
    @show_bottom_border = show_bottom_border
  end

  def wrapper_classes
    classes = ["cms-full-width-text-row"]
    classes << "#{@background_color}-bg" if @background_color
    classes << "has-border" if @show_bottom_border
    classes
  end
end
