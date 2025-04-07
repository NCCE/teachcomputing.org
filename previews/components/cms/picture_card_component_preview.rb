class Cms::PictureCardComponentPreview < ViewComponent::Preview
  layout "full-width"

  def default
    card_section = Cms::Mocks::DynamicComponents::Blocks::PictureCardSection.as_model(
      picture_cards: Array.new(3) {
                       Cms::Mocks::DynamicComponents::ContentBlocks::PictureCard.generate_data(
                         color_theme: nil
                       )
                     }
    )

    render(Cms::CardWrapperComponent.new(
      title: card_section.title,
      cards_block: card_section.cards_block,
      background_color: nil,
      cards_per_row: 3
    ))
  end

  def with_color_theme
    card_section = Cms::Mocks::DynamicComponents::Blocks::PictureCardSection.as_model(
      picture_cards: Array.new(3) {
                       Cms::Mocks::DynamicComponents::ContentBlocks::PictureCard.generate_data(
                         color_theme: {data: Cms::Mocks::Meta::ColorScheme.generate_data(name: "standard")}
                       )
                     }
    )

    render(Cms::CardWrapperComponent.new(
      title: card_section.title,
      cards_block: card_section.cards_block,
      background_color: nil,
      cards_per_row: 3
    ))
  end

  def with_background_color
    card_section = Cms::Mocks::DynamicComponents::Blocks::PictureCardSection.as_model(
      picture_cards: Array.new(3) {
                       Cms::Mocks::DynamicComponents::ContentBlocks::PictureCard.generate_data(
                         color_theme: {data: Cms::Mocks::Meta::ColorScheme.generate_data(name: "standard")}
                       )
                     }
    )

    render(Cms::CardWrapperComponent.new(
      title: card_section.title,
      cards_block: card_section.cards_block,
      background_color: "light-grey",
      cards_per_row: 3
    ))
  end
end
