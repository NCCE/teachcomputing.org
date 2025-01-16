class CmsResourceCardComponentPreview < ViewComponent::Preview
  layout "full-width"

  def default
    card_section = Cms::Mocks::ResourceCardSection.as_model(
      number_of_cards: 3,
      button_text: "Click here",
      button_link: "https://www.example.com/"
    )

    render(CardWrapperComponent.new(
      title: card_section.title,
      cards_block: card_section.cards_block,
      background_color: "light-grey",
      cards_per_row: 3
    ))
  end

  def two_cards_per_row_no_button
    card_section = Cms::Mocks::ResourceCardSection.as_model(
      number_of_cards: 2
    )

    render(CardWrapperComponent.new(
      title: card_section.title,
      cards_block: card_section.cards_block,
      background_color: card_section.background_color,
      cards_per_row: 2
    ))
  end

  def with_color_theme_and_icon
    card_section = Cms::Mocks::ResourceCardSection.as_model(
      number_of_cards: 3,
      color_scheme: "standard",
      button_text: Faker::Lorem.words(number: 2),
      button_link: Faker::Internet.url,
      icon: {data: Cms::Mocks::Image.generate_raw_data}
    )

    render(CardWrapperComponent.new(
      title: card_section.title,
      cards_block: card_section.cards_block,
      background_color: nil,
      cards_per_row: 3
    ))
  end
end
