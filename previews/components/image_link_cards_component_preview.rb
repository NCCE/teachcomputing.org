class ImageLinkCardsComponentPreview < ViewComponent::Preview
  def default
    # Component takes a list of cards and renders them in grid
    cards = [{
      title_locale: 'pages.supporting_partners.arm.title',
      link_url: 'https://www.arm.com/',
      image_path: 'media/images/partners/arm.svg',
      img_alt_locale: 'pages.supporting_partners.arm.img_alt',
      text_locale: 'pages.supporting_partners.arm.text_html'
    },
    {
      title_locale: 'pages.supporting_partners.arm.title',
      link_url: 'https://www.arm.com/',
      image_path: 'media/images/partners/arm.svg',
      img_alt_locale: 'pages.supporting_partners.arm.img_alt',
      text_locale: 'pages.supporting_partners.arm.text_html'
    }]
    render(ImageLinkCardsComponent.new(cards: cards))
  end
end
