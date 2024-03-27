# frozen_string_literal: true

class BorderedCardsComponent < ViewComponent::Base
  def initialize(cards:, class_name: nil, cards_per_row: 2)
    # initially this component only supported one link per card, but now we need
    # to add mutiple links per card. old callers may be using cards with a :link
    # field, so we copy that over to a :links field with one one element
    @cards = cards.map! do |card|
      card[:links] ||= []
      card[:links] << card[:link] if card.key?(:link)
      card.delete(:link)
      card
    end

    @class_name = class_name
    @cards_per_row = cards_per_row
  end

  def custom_properties
    "--cards-per-row: #{@cards_per_row};"
  end

  def custom_card_properties(card)
    case card[:top_color]
    in :green
      "--top-color: var(--green);"
    in :orange
      "--top-color: var(--orange);"
    in :yellow
      "--top-color: var(--yellow);"
    else
      ""
    end
  end

  def link_class(button)
    case button
    when :lime, true
      "govuk-button button bordered-card__get-involved-button"
    when :white
      "govuk-button ncce-button--white bordered-card__get-involved-button"
    when :blank
      ""
    else
      "ncce-link"
    end
  end

  def render?
    @cards.present?
  end
end
