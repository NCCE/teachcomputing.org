class LogoCardsComponentPreview < ViewComponent::Preview
  def two_cards
    params = {
      class_name: "logo-cards-example-component",
      cards: [
        {
          image_url: "media/images/logos/ncce-logo-with-bg.svg",
          title_link: {
            title: "A link",
            title_url: "/curriculum"
          }
        },
        {
          image_url: "media/images/logos/ncce-logo-with-bg.svg",
          title_link: {
            title: "A link",
            title_url: "/curriculum"
          }
        }
      ]
    }

    render(LogoCardsComponent.new(**params))
  end
end
