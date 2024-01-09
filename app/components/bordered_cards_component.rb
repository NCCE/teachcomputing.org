# frozen_string_literal: true

class BorderedCardsComponent < ViewComponent::Base
  def initialize(cards:, class_name: nil, cards_per_row: 2)
    @cards = cards
    @class_name = class_name
    @cards_per_row = cards_per_row
  end

  def custom_properties
    "--cards-per-row: #{@cards_per_row};"
  end

  def link_class(button)
    case button
    when :lime, true
      "govuk-button button bordered-card__get-involved-button"
    when :white
      "govuk-button ncce-button__white bordered-card__get-involved-button"
    else
      "ncce-link"
    end
  end

  def render?
    @cards.present?
  end
end
