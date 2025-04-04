class Cms::ProgrammeCardWrapperComponentPreview < ViewComponent::Preview
  layout "full-width"

  def one_card_per_row
    card_section = Cms::Mocks::DynamicComponents::Blocks::ProgrammePictureCardSection.as_model

    render(Cms::ProgrammeCardWrapperComponent.new(
      title: card_section.title,
      cards_block: card_section.cards_block,
      background_color: "light-grey",
      cards_per_row: 1,
      programme: Programme.i_belong
    ))
  end

  def two_cards_per_row
    card_section = Cms::Mocks::DynamicComponents::Blocks::ProgrammePictureCardSection.as_model

    render(Cms::ProgrammeCardWrapperComponent.new(
      title: card_section.title,
      cards_block: card_section.cards_block,
      background_color: "light-grey",
      cards_per_row: 2,
      programme: Programme.i_belong
    ))
  end

  def three_cards_per_row
    card_section = Cms::Mocks::DynamicComponents::Blocks::ProgrammePictureCardSection.as_model

    render(Cms::ProgrammeCardWrapperComponent.new(
      title: card_section.title,
      cards_block: card_section.cards_block,
      background_color: "light-grey",
      cards_per_row: 3,
      programme: Programme.i_belong
    ))
  end
end
