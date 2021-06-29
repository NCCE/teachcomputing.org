# frozen_string_literal: true

class BorderedCardsComponent < ViewComponent::Base
  def initialize(cards:, class_name: nil, cards_per_row: 2)
    @cards = cards.collect { |card| assign_card card }
    @class_name = class_name
    @cards_per_row = cards_per_row
  end

  def assign_card(title:, text:, link:, class_name: nil, image_url: nil)
    { title: title, text: text, class_name: class_name, image_url: image_url, link: assign_link(link) }
  end

  def assign_link(link_title:, link_url:, tracking_page: nil, tracking_label: nil, class_name: nil)
    { link_title: link_title, link_url: link_url, tracking_page: tracking_page, tracking_label: tracking_label, class_name: class_name }
  end

  def custom_properties
    "--cards-per-row: #{@cards_per_row};"
  end

  def render?
    @cards.present?
  end
end
