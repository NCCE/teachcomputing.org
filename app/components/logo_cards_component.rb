# frozen_string_literal: true

class LogoCardsComponent < ViewComponent::Base
  def initialize(cards:, class_name: nil, cards_per_row: 2)
    @cards = cards.collect { |card| assign_card card }
    @class_name = class_name
    @cards_per_row = cards_per_row
  end

  def assign_card(title_link:, class_name: nil, image_url: nil)
    { title_link: assign_title_link(title_link), class_name: class_name, image_url: image_url }
  end

  def assign_title_link(title:, title_url:, tracking_page: nil, tracking_label: nil)
    { title: title, title_url: title_url, tracking_page: tracking_page, tracking_label: tracking_label }
  end

  def custom_properties
    "--cards-per-row: #{@cards_per_row};"
  end

  def render?
    @cards.present?
  end
end
