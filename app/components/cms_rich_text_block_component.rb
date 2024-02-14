# frozen_string_literal: true

class CmsRichTextBlockComponent < ViewComponent::Base
  def initialize(blocks:)
    @blocks = blocks
  end

  def call
    @blocks.to_s
  end
end
