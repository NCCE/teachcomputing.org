# frozen_string_literal: true

class MixedCardsComponent < ViewComponent::Base
  def initialize(card_groups:)
    @card_groups = card_groups
  end

  def render?
    @card_groups.present?
  end
end

