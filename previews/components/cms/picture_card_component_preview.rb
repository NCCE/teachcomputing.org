class Cms::PictureCardComponentPreview < ViewComponent::Preview
  layout "full-width"

  def default
    card_section = Cms::Mocks::PictureCardSection.as_model(number_of_cards: 3)

    render(Cms::CardWrapperComponent.new(
      title: card_section.title,
      cards_block: card_section.cards_block,
      background_color: nil,
      cards_per_row: 3
    ))
  end

  def two_cards_per_row
    card_section = Cms::Mocks::PictureCardSection.as_model(number_of_cards: 4)

    render(Cms::CardWrapperComponent.new(
      title: card_section.title,
      cards_block: card_section.cards_block,
      background_color: "light-grey",
      cards_per_row: 2
    ))
  end

  def with_color_theme
    card_section = Cms::Mocks::PictureCardSection.as_model(number_of_cards: 3, color_scheme: "standard")

    render(Cms::CardWrapperComponent.new(
      title: card_section.title,
      cards_block: card_section.cards_block,
      background_color: nil,
      cards_per_row: 3
    ))
  end
end
