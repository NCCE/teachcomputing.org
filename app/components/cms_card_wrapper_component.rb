# frozen_string_literal: true

class CmsCardWrapperComponent < ViewComponent::Base
  def initialize(title:, cards_block:, cards_per_row:, background_color:)
    @title = title
    @cards_block = cards_block
    @cards_per_row = cards_per_row
    @background_color = background_color
  end

  def cards_per_row
    "--cards-per-row: #{@cards_per_row}"
  end
end
