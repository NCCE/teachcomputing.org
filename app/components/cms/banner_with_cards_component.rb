# frozen_string_literal: true

class Cms::BannerWithCardsComponent < ViewComponent::Base
  delegate :dark_background?, to: :helpers

  def initialize(title:, text_content:, cards:, background_color:)
    @title = title
    @text_content = text_content
    @cards = cards
    @background_color = background_color
  end

  def text_content_classes
    return "text-content--light" if dark_background?(@background_color)

    "text-content"
  end
end
