# frozen_string_literal: true

class ImageLinkCardsComponent < ViewComponent::Base
  def initialize(cards:)
    @cards = cards
  end
end
