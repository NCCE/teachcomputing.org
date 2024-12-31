# frozen_string_literal: true

class CmsCardWrapperComponent < ViewComponent::Base
  def initialize(cards_block:, cards_per_row:, title: nil, sub_text: nil, background_color: nil)
    @title = title
    @sub_text = sub_text
    @cards_block = cards_block
    @cards_per_row = cards_per_row
    @background_color = background_color
  end

  def cards_per_row
    "--cards-per-row: #{@cards_per_row}"
  end
end
