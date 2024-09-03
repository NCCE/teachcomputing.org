# frozen_string_literal: true

class CmsHorizontalCardComponent < ViewComponent::Base
  def initialize(title:, body_blocks:)
    @title = title
    @body_blocks = body_blocks
  end
end
