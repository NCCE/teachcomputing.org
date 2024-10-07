class CmsPictureCardComponentPreview < ViewComponent::Preview
  layout "full-width"

  def default
    card_section = Cms::Mocks::PictureCardSection.as_model(number_of_cards: 3)

    render(CmsCardWrapperComponent.new(
      title: card_section.title,
      cards_block: card_section.cards_block,
      background_color: card_section.background_color,
      cards_per_row: 3
    ))
  end

  def two_cards_per_row
    card_section = Cms::Mocks::PictureCardSection.as_model(number_of_cards: 4)

    render(CmsCardWrapperComponent.new(
      title: card_section.title,
      cards_block: card_section.cards_block,
      background_color: card_section.background_color,
      cards_per_row: 2
    ))
  end

  def with_colour_theme
    card_section = Cms::Mocks::PictureCardSection.as_model(number_of_cards: 3, colour_scheme: "standard")

    render(CmsCardWrapperComponent.new(
      title: card_section.title,
      cards_block: card_section.cards_block,
      background_color: card_section.background_color,
      cards_per_row: 3
    ))
  end
end
