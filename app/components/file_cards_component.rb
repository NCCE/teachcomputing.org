# frozen_string_literal: true

class FileCardsComponent < ViewComponent::Base
  def initialize(cards:, tracking: nil)
    @cards = cards
    @tracking = tracking
  end

  def render?
    @cards.present?
  end
end
