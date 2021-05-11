class HeroImageComponentPreview < ViewComponent::Preview
  def default
    params = OpenStruct.new(
      {
        class_name: 'tapestry-bg',
        title: 'About us',
        text: "This is an example of a hero image component. It's a hero and it has an image, it also has some text.",
        image: 'media/images/landing-pages/pri-hero.png'
      }
    )

    render(HeroImageComponent.new(params))
  end
end
