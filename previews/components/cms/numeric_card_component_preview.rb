# frozen_string_literal: true

class Cms::NumericCardComponentPreview < ViewComponent::Preview
  def default
    card_section = Cms::Mocks::DynamicComponents::Blocks::NumericCardSection.as_model(
      number_of_cards: 3
    )

    render(Cms::CardWrapperComponent.new(
      title: card_section.title,
      cards_block: card_section.cards_block,
      background_color: "light-grey",
      cards_per_row: 3
    ))
  end
end
