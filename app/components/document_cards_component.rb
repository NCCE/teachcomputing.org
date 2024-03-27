# frozen_string_literal: true

class DocumentCardsComponent < ViewComponent::Base
  def initialize(cards:, class_name: nil, cards_per_row: 3, show_border: false, tracking_category: nil)
    @cards = cards
    @class_name = class_name
    @cards_per_row = cards_per_row
    @show_border = show_border
    @tracking_category = tracking_category
  end

  def css_variables
    "--cards-per-row: #{@cards_per_row};"
  end

  # The difference in approach here is to allow for a boolean, as I can't find a sensible
  # way to use a css variable as a bool, and defining the box-shadow width here feels wrong.
  def data_attributes
    {"show-border": @show_border}
  end

  def tracking_data(label)
    return nil unless @tracking_category.present? && label.present?

    {
      event_action: "click",
      event_category: @tracking_category,
      event_label: label
    }
  end

  def render?
    @cards.present?
  end
end
