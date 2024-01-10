class BorderedCardsComponentPreview < ViewComponent::Preview
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
          text: "This is an example of a page card component. It has more text than the other to display how elements are evenly spaced.",
          link: {
            link_title: "A link",
            link_url: "/curriculum"
          }
        }
      ]
    }

    render(BorderedCardsComponent.new(**params))
  end

  def two_cards
    params = {
      class_name: "page-cards-example-component",
      cards: [
        {
          title: "Card 1",
          text: "This is an example of a page card component without an image.",
          link: {
            link_title: "A link",
            link_url: "/curriculum"
          }
        },
        {
          image_url: "media/images/logos/ncce-logo-with-bg.svg",
          title: "Card 2",
          text: "This is an example of a page card component.",
          link: {
            link_title: "A link",
            link_url: "/curriculum"
          }
        }
      ]
    }

    render(BorderedCardsComponent.new(**params))
  end

  def more_cards
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
          text: "This is an example of a page card component.",
          link: {
            link_title: "A link",
            link_url: "/curriculum"
          }
        },
        {
          image_url: "media/images/logos/ncce-logo-with-bg.svg",
          title: "Card 3",
          text: "This is an example of a page card component. It has more text than the other to display how elements are evenly spaced.",
          link: {
            link_title: "A link",
            link_url: "/curriculum"
          }
        },
        {
          image_url: "media/images/logos/ncce-logo-with-bg.svg",
          title: "Card 4",
          text: "This is an example of a page card component.",
          link: {
            link_title: "A link",
            link_url: "/curriculum"
          }
        },
        {
          image_url: "media/images/logos/ncce-logo-with-bg.svg",
          title: "Card 5",
          text: "This is an example of a page card component. It has more text than the other to display how elements are evenly spaced. This one has even more text which should provide some variation.",
          link: {
            link_title: "A link",
            link_url: "/curriculum"
          }
        },
        {
          image_url: "media/images/logos/ncce-logo-with-bg.svg",
          title: "Card 6",
          text: "This is an example of a page card component.",
          link: {
            link_title: "A link",
            link_url: "/curriculum"
          }
        }
      ]
    }

    render(BorderedCardsComponent.new(**params))
  end
end
