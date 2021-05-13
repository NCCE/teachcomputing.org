class HeroImageComponentPreview < ViewComponent::Preview
  def default
    params = {
      class_name: 'tapestry-bg',
      title: 'About us',
      text: "This is an example of a hero image component. It's a hero and it has an image, it also has some text.",
      image_url: 'media/images/landing-pages/pri-hero.png',
      image_title: 'Image title'
    }

    render(HeroImageComponent.new(params))
  end
end
