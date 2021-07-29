class ImageLinkCardComponentPreview < ViewComponent::Preview
  def default
    # Component takes paths to locales and renders the text.
    data = {
      title_locale: 'pages.supporting_partners.arm.title',
      link_url: 'https://www.arm.com/',
      image_path: 'media/images/partners/arm.svg',
      img_alt_locale: 'pages.supporting_partners.arm.img_alt',
      text_locale: 'pages.supporting_partners.arm.text_html'
    }
    render(ImageLinkCardComponent.new(image_link_card: data))
  end
end
