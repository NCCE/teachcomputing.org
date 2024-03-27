class NonBorderedCardsComponentPreview < ViewComponent::Preview
  def two_cards_one_with_no_image
    params = {
      class_name: "page-cards-example-component",
      cards: [
        {
          image_url: nil,
          title: "Card 1",
          text: "This is an example of a page card component.",
          link: {
            link_title: "A link",
            link_url: "/curriculum"
          }
        },
        {
          image_url: "media/images/logos/ncce-logo-with-bg.svg",
          title: "Card 2",
          text: "This is an example.",
          link: {
            link_title: "A link",
            link_url: "/curriculum"
          }
        }
      ]
    }

    render(NonBorderedCardsComponent.new(**params))
  end

  def two_cards
    params = {
      class_name: "page-cards-example-component",
      cards: [
        {
          image_url: "media/images/logos/ncce-logo-with-bg.svg",
          title: "Card 1",
          text: "This is an example of a page card component.",
          link: {
            link_title: "A link",
            link_url: "/curriculum"
          }
        },
        {
          image_url: "media/images/logos/ncce-logo-with-bg.svg",
          title: "Card 2",
          text: "This is an example of a page card component with a bit more text than the other.",
          link: {
            link_title: "A link",
            link_url: "/curriculum"
          }
        }
      ]
    }

    render(NonBorderedCardsComponent.new(**params))
  end
end
