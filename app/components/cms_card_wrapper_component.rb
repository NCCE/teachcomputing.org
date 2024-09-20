# frozen_string_literal: true

class CmsCardWrapperComponent < ViewComponent::Base
  def initialize(title:, cards_block:, cards_per_row:, background_colour:)
    @title = title
    @cards_block = cards_block
    @cards_per_row = cards_per_row
    @background_colour = background_colour
  end
end
