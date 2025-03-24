class Cms::BannerWithCardsComponentPreview < ViewComponent::Preview
  layout "full-width"

  def default
    @banner_with_cards = Cms::Mocks::DynamicComponents::Blocks::BannerWithCards.as_model
    render(Cms::BannerWithCardsComponent.new(
      title: @banner_with_cards.title,
      text_content: @banner_with_cards.text_content,
      cards: @banner_with_cards.cards,
      background_color: "purple"
    ))
  end
end
