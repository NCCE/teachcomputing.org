class FullImageBannerComponentPreview < ViewComponent::Preview
  include ActionView::Helpers::UrlHelper

  def default
    render(FullImageBannerComponent.new(title: "A Great Title",
      text: "Some wonderful text to go with it",
      background_color: "purple-bg",
      image: {
        url: "media/images/pages/secondary-toolkit/secondary_careers.jpeg",
        alt: "teach computing secondary careers"
      },
      link: link_to("Find out more", "")))
  end
end
