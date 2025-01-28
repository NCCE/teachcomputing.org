# frozen_string_literal: true

class Cms::TextWithAsidesComponent < Cms::WithAsidesComponent
  def initialize(blocks:, asides:, background_color:)
    super(aside_sections: asides)
    @blocks = blocks
    @background_color = background_color
  end
end
