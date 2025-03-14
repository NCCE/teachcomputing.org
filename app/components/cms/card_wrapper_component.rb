# frozen_string_literal: true

class Cms::CardWrapperComponent < ViewComponent::Base
  def initialize(cards_block:, cards_per_row:, title: nil, intro_text: nil, background_color: nil, programme: nil, title_as_paragraph: false)
    @title = title
    @intro_text = intro_text
    @cards_block = cards_block
    @cards_per_row = cards_per_row
    @background_color = background_color
    @programme = programme
    @title_as_paragraph = title_as_paragraph

    if @programme
      @cards_block = @cards_block.map do |card|
        card.programme = @programme
        card
      end
    end
  end

  def cards_per_row
    "--cards-per-row: #{@cards_per_row}"
  end

  def title_html
    if @title_as_paragraph
      content_tag :p, @title, class: "govuk-body-m cms-card-wrapper__title"
    else
      content_tag :h2, @title, class: "govuk-heading-m cms-card-wrapper__title"
    end
  end
end
