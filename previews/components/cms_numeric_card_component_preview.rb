# frozen_string_literal: true

class CmsNumericCardComponentPreview < ViewComponent::Preview
  def default
    card_section = Cms::Mocks::NumericCardSection.as_model(
      number_of_cards: 3
    )

    render(CmsCardWrapperComponent.new(
      title: card_section.title,
      cards_block: card_section.cards_block,
      background_color: "light-grey",
      cards_per_row: 3
    ))
  end
end
