class ImageLinkCardsComponentPreview < ViewComponent::Preview
  def default
    # Component takes a list of cards and renders them in grid
    cards = [
      {
        title_locale: "test.image_link_card.title",
        link_url: "https://www.example.com/",
        image_path: "media/images/test/example.svg",
        img_alt_locale: "test.image_link_card.img_alt",
        text_locale: "test.image_link_card.text_html"
      },
      {
        title_locale: "test.image_link_card.title",
        link_url: "https://www.example.com/",
        image_path: "media/images/test/example.svg",
        img_alt_locale: "test.image_link_card.img_alt",
        text_locale: "test.image_link_card.text_html"
      }
    ]
    render(ImageLinkCardsComponent.new(cards: cards))
  end
end
