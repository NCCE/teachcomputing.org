# frozen_string_literal: true

class BorderedCardsWrapperComponent < ViewComponent::Base
  renders_many :cards

  def initialize(cards_per_row:, title: nil)
    @cards_per_row = cards_per_row
    @title = title
  end

  def custom_properties
    "--cards-per-row: #{@cards_per_row};"
  end
end
