class Cms::ResourceCardComponentPreview < ViewComponent::Preview
  layout "full-width"

  def default
    card_section = Cms::Mocks::DynamicComponents::Blocks::ResourceCardSection.as_model(
      resource_cards: Array.new(3) {
                        Cms::Mocks::DynamicComponents::ContentBlocks::ResourceCard.generate_data(
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

  def with_icons
    card_section = Cms::Mocks::DynamicComponents::Blocks::ResourceCardSection.as_model(
      resource_cards: Array.new(3) {
                        Cms::Mocks::DynamicComponents::ContentBlocks::ResourceCard.generate_data(
                          color_theme: {data: Cms::Mocks::ColorScheme.generate_data(name: "standard")},
                          icon: {data: Cms::Mocks::ImageComponents::Image.generate_raw_data}
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

  def no_title
    card_section = Cms::Mocks::DynamicComponents::Blocks::ResourceCardSection.as_model(
      resource_cards: Array.new(3) {
                        Cms::Mocks::DynamicComponents::ContentBlocks::ResourceCard.generate_data(
                          color_theme: {data: Cms::Mocks::ColorScheme.generate_data(name: "standard")},
                          title: nil
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
    card_section = Cms::Mocks::DynamicComponents::Blocks::ResourceCardSection.as_model(
      resource_cards: Array.new(3) {
                        Cms::Mocks::DynamicComponents::ContentBlocks::ResourceCard.generate_data(
                          color_theme: {data: Cms::Mocks::ColorScheme.generate_data(name: "standard")}
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

  def with_button
    card_section = Cms::Mocks::DynamicComponents::Blocks::ResourceCardSection.as_model(
      resource_cards: Array.new(3) {
                        Cms::Mocks::DynamicComponents::ContentBlocks::ResourceCard.generate_data(
                          color_theme: {data: Cms::Mocks::ColorScheme.generate_data(name: "standard")},
                          button_text: "Click here",
                          button_link: "https://www.google.com"
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
end
