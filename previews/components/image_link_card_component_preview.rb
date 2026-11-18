class ImageLinkCardComponentPreview < ViewComponent::Preview
  def default
    # Component takes paths to locales and renders the text.
    card = {
      title_locale: "test.image_link_card.title",
      link_url: "https://www.example.com/",
      image_path: "media/images/test/example.svg",
      img_alt_locale: "test.image_link_card.img_alt",
      text_locale: "test.image_link_card.text_html"
    }
    render(ImageLinkCardComponent.new(image_link_card: card))
  end
end
