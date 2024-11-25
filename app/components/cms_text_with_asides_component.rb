# frozen_string_literal: true

class CmsTextWithAsidesComponent < CmsWithAsidesComponent
  def initialize(blocks:, asides:, background_color:)
    super(aside_sections: asides)
    @blocks = blocks
    @background_color = background_color
  end
end
