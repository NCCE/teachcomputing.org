class Cms::CardWrapperComponentPreview < ViewComponent::Preview
  layout "full-width"

  def one_card_per_row
    render(Cms::CardWrapperComponent.new(
      title: "Section title",
      cards_block: Cms::Mocks::ResourceCard.generate(
        title: "Card Title",
        button_text: "Click here",
        button_link: "https://www.example.com"
      ),
      cards_per_row: 1,
      background_color: "light-grey"
    ))
  end

  def two_cards_per_row
    render(Cms::CardWrapperComponent.new(
      title: "Section title",
      cards_block: Cms::Mocks::ResourceCard.generate(
        title: "Card Title",
        button_text: "Click here",
        button_link: "https://www.example.com"
      ),
      cards_per_row: 2,
      background_color: "light-grey"
    ))
  end

  def three_cards_per_row
    render(Cms::CardWrapperComponent.new(
      title: "Section title",
      cards_block: Cms::Mocks::ResourceCard.generate(
        title: "Card Title",
        button_text: "Click here",
        button_link: "https://www.example.com"
      ),
      cards_per_row: 3,
      background_color: "light-grey"
    ))
  end
end
