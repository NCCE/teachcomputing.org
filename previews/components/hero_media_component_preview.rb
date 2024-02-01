class HeroMediaComponentPreview < ViewComponent::Preview
  layout "full-width"

  def with_image
    params = {
      class_name: "lime-green-bg",
      title: "About us",
      text: "This is an example of a hero image component. It's a hero and it has an image, it also has some text.",
      image: {
        url: "media/images/landing-pages/pri-hero.png",
        title: "Image title"
      }
    }

    render(HeroMediaComponent.new(**params))
  end

  def with_video
    params = {
      class_name: "lime-green-bg",
      title: "About us",
      text: "This is an example of a hero image component. It's a hero and it has an image, it also has some text.",
      video: {
        url: "https://www.youtube.com/embed/hPpAB-g_9Kc",
        page: "A Page",
        label: "Some video"
      }
    }

    render(HeroMediaComponent.new(**params))
  end
end
