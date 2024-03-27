# frozen_string_literal: true

class LogoButtonImageCardComponentPreview < ViewComponent::Preview
  def default
    params = {
      logo: {path: "media/images/logos/isaac-logo.svg", alt: "Isaac Logo"},
      image: {
        path: "media/images/pages/secondary-senior-leaders/teaching.png",
        alt: "A teacher teaching"
      },
      title: "Logo Button Image Card Component",
      text: "This is an example of a logo button image card component. This " \
            "is the main body text and it may span multiple lines so our text " \
            "should attempt to do this too. There will also be a button " \
            "displayed. All are populated by parameters.",
      button: {
        button_title: "Example button",
        button_url: "/"
      },
      class_name: "logo-button-image-card-example-component"
    }
    render(LogoButtonImageCardComponent.new(**params))
  end
end
