class Cms::PictureCardComponentPreview < ViewComponent::Preview
  layout "full-width"

  def default
    card_section = Cms::Mocks::PictureCardSection.as_model

    render(Cms::CardWrapperComponent.new(
      title: card_section.title,
      cards_block: card_section.cards_block,
      background_color: nil,
      cards_per_row: 3
    ))
  end
end
