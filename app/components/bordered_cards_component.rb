# frozen_string_literal: true

class BorderedCardsComponent < ViewComponent::Base
  def initialize(cards:, class_name: nil)
    @cards = cards
    @class_name = class_name
  end

  def render?
    @cards.present?
  end
end
