# frozen_string_literal: true

class Cms::CardWrapperComponent < ViewComponent::Base
  def initialize(cards_block:, cards_per_row:, title: nil, background_color: nil, title_as_paragraph: false)
    @title = title
    @cards_block = cards_block
    @cards_per_row = cards_per_row
    @background_color = background_color
    @title_as_paragraph = title_as_paragraph
  end

  def cards_per_row
    "--cards-per-row: #{@cards_per_row}"
  end

  def title_html
    if @title_as_paragraph
      content_tag :p, @title, class: "govuk-body-m"
    else
      content_tag :h2, @title, class: "govuk-heading-m"
    end
  end
end
