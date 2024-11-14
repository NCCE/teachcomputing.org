# frozen_string_literal: true

class CmsTextWithAsidesComponent < CmsWithAsidesComponent
  def initialize(blocks:, asides:)
    super(aside_sections: asides)
    @blocks = blocks
  end
end
