# frozen_string_literal: true

class DocumentCardsComponent < ViewComponent::Base
  def initialize(cards:, class_name: nil, cards_per_row: 3, show_border: false)
    @cards = cards.collect { |card| assign_card card }
    @class_name = class_name
    @cards_per_row = cards_per_row
    @show_border = show_border
  end

  def assign_card(title_link:, body:, class_name: nil, date: nil)
    { title_link: assign_title_link(title_link), body: assign_body(body), class_name: class_name, date: date }
  end

  def assign_body(text:, tokens: nil)
    { text: text, tokens: tokens }
  end

  def assign_title_link(title:, title_url:, tracking_page: nil, tracking_label: nil)
    { title: title, title_url: title_url, tracking_page: tracking_page, tracking_label: tracking_label }
  end

  def css_variables
    "--cards-per-row: #{@cards_per_row}"
  end

  # The difference in approach here is to allow for a boolean, as I can't find a sensible
  # way to use a css variable as a bool, and defining the box-shadow width here feels wrong.
  def data_attributes
    { "show-border": @show_border }
  end

  def render?
    @cards.present?
  end
end
