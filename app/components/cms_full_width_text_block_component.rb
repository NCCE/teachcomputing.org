# frozen_string_literal: true

class CmsFullWidthTextBlockComponent < ViewComponent::Base
  def initialize(blocks:)
    @blocks = blocks
  end
end
