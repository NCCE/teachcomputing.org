# frozen_string_literal: true

class PageCardsComponent < ViewComponent::Base
  def initialize(cards:, class_name: nil)
    @class_name = class_name
    @cards = cards
  end
end
