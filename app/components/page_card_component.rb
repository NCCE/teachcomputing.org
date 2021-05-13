# frozen_string_literal: true

class PageCardComponent < ViewComponent::Base
  def initialize(class_name:, cards:)
    @class_name = class_name
    @cards = cards
  end
end
