class Cms::CardWrapperComponentPreview < ViewComponent::Preview
  layout "full-width"

  def one_card_per_row
    card_section = Cms::Mocks::DynamicComponents::Blocks::ResourceCardSection.as_model

    render(Cms::CardWrapperComponent.new(
      title: card_section.title,
      cards_block: card_section.cards_block,
      background_color: "light-grey",
      cards_per_row: 1
    ))
  end

  def two_cards_per_row
    card_section = Cms::Mocks::DynamicComponents::Blocks::ResourceCardSection.as_model

    render(Cms::CardWrapperComponent.new(
      title: card_section.title,
      cards_block: card_section.cards_block,
      background_color: "light-grey",
      cards_per_row: 2
    ))
  end

  def three_cards_per_row
    card_section = Cms::Mocks::DynamicComponents::Blocks::ResourceCardSection.as_model

    render(Cms::CardWrapperComponent.new(
      title: card_section.title,
      cards_block: card_section.cards_block,
      background_color: "light-grey",
      cards_per_row: 3
    ))
  end
end
