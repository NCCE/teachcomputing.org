class CmsPictureCardComponentPreview < ViewComponent::Preview
  layout "full-width"

  def default
    card_section = Cms::Mocks::PictureCardSection.as_model

    render(CmsCardWrapperComponent.new(
      cards_block: card_section.cards_block,
      background_color: card_section.background_color,
      cards_per_row: 3
    ))
  end
end
