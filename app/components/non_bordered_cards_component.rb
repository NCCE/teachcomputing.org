# frozen_string_literal: true

class NonBorderedCardsComponent < ViewComponent::Base
  def initialize(cards:, class_name: nil, cards_per_row: 2)
    @cards = cards
    @class_name = class_name
    @cards_per_row = cards_per_row
  end

  def custom_properties
    "--cards-per-row: #{@cards_per_row};"
  end

  def render?
    @cards.present?
  end

  private

  def link_method(card)
    card[:link][:link_method] unless card[:link][:link_method].in? %i[get GET]
  end
end
