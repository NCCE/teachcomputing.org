# frozen_string_literal: true

class Cms::ButtonBlockComponent < ViewComponent::Base
  def initialize(buttons:, background_color:, padding:, alignment:, full_width:)
    @buttons = buttons
    @background_color = background_color
    @padding = padding
    @alignment = alignment
    @full_width = full_width
  end

  def column
    return "full" if @full_width
    "two-thirds"
  end

  def alignment_class
    "cms-button-block--#{@alignment}"
  end

  def padding
    return { all: 0 } unless @padding
    {}
  end

end
