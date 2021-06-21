# frozen_string_literal: true

class BorderedTripleCardsComponent < ViewComponent::Base
  def initialize(cards:, class_name: nil, cards_per_row: 3)
    @cards = cards.collect { |card| assign_card card }
    @class_name = class_name
    @cards_per_row = cards_per_row
  end

  def assign_card(title:, text:, list_items:, link:, class_name: nil, image_url: nil)
    { title: title, text: text, list_items: list_items, class_name: class_name, image_url: image_url, link: assign_link(link) }
  end

  def assign_link(link_title:, link_url:, tracking_page: nil, tracking_label: nil, class_name: nil)
    { link_title: link_title, link_url: link_url, tracking_page: tracking_page, tracking_label: tracking_label }
  end

  def custom_properties
    "--cards-per-row: #{@cards_per_row};"
  end

  def render?
    @cards.present?
  end
end
