# frozen_string_literal: true

class FileCardsComponent < ViewComponent::Base
  def initialize(cards:, title: nil, tracking: nil)
    @cards = cards
    @title = title
    @tracking = tracking
  end

  def render?
    @cards.present?
  end
end
