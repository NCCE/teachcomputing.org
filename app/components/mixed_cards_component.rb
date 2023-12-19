# frozen_string_literal: true

class MixedCardsComponent < ViewComponent::Base
  def initialize(cards:)
    @cards = cards
  end

  def render?
    @cards.present?
  end
end

