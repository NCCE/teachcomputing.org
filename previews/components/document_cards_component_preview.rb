class DocumentCardsComponentPreview < ViewComponent::Preview
  include ActionView::Helpers::UrlHelper

  def cards_with_border
    params = {
      class_name: "page-cards-example-component",
      show_border: true,
      cards: [
        {
          date: "May 2021",
          title_link: {
            title: "Card 1",
            url: "/"
          },
          body: {
            text: "This is some example text"
          }
        },
        {
          date: "May 2021",
          title_link: {
            title: "Card 1",
            url: "/"
          },
          body: {
            text: "This is some example text"
          }
        }
      ]
    }

    render(DocumentCardsComponent.new(**params))
  end

  def two_cards_no_border
    params = {
      class_name: "page-cards-example-component",
      cards: [
        {
          title_link: {
            title: "Card 1",
            url: "/"
          },
          body: {
            text: "This is an example of a card without a date"
          }
        },
        {
          date: "June 2021",
          title_link: {
            title: "Card 1",
            url: "/"
          },
          body: {
            text: "This is some longer example text. It should span multiple lines and provide a useful example of how wrapping works."
          }
        }
      ]
    }

    render(DocumentCardsComponent.new(**params))
  end

  def three_cards_in_row
    params = {
      class_name: "page-cards-example-component",
      cards_per_row: 3,
      show_border: true,
      cards: [
        {
          title_link: {
            title: "Card 1",
            url: "/"
          },
          body: {
            text: "This is an example of a card without a date"
          }
        },
        {
          date: "June 2021",
          title_link: {
            title: "Card 1",
            url: "/"
          },
          body: {
            text: "This is some longer example text. It should span multiple lines and provide a useful example of how wrapping works."
          }
        },
        {
          date: "June 2021",
          title_link: {
            title: "Card 1",
            url: "/"
          },
          body: {
            text: "This is some longer example text. It should span multiple lines and provide a useful example of how wrapping works."
          }
        }
      ]
    }

    render(DocumentCardsComponent.new(**params))
  end
end
