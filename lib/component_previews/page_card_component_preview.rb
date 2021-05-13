class PageCardComponentPreview < ViewComponent::Preview
  def two_cards
    params = {
      class_name: 'page-card-example-component',
      cards: [
        {
          image_url: 'media/images/logos/tc-logo-with-bg.svg',
          title: 'Card 1',
          text: 'This is an example of a page card component.',
          link_title: 'A link',
          link_url: '/curriculum'
        },
        {
          image_url: 'media/images/logos/tc-logo-with-bg.svg',
          title: 'Card 2',
          text: 'This is an example of a page card component.',
          link_title: 'A link',
          link_url: '/curriculum'
        }
      ]
    }

    render(PageCardComponent.new(params))
  end

  def more_cards
    params = {
      class_name: 'page-card-example-component',
      cards: [
        {
          image_url: 'media/images/logos/tc-logo-with-bg.svg',
          title: 'Card 1',
          text: 'This is an example of a page card component.',
          link_title: 'A link',
          link_url: '/curriculum'
        },
        {
          image_url: 'media/images/logos/tc-logo-with-bg.svg',
          title: 'Card 2',
          text: 'This is an example of a page card component.',
          link_title: 'A link',
          link_url: '/curriculum'
        },
        {
          image_url: 'media/images/logos/tc-logo-with-bg.svg',
          title: 'Card 3',
          text: 'This is an example of a page card component.',
          link_title: 'A link',
          link_url: '/curriculum'
        },
        {
          image_url: 'media/images/logos/tc-logo-with-bg.svg',
          title: 'Card 4',
          text: 'This is an example of a page card component.',
          link_title: 'A link',
          link_url: '/curriculum'
        },
        {
          image_url: 'media/images/logos/tc-logo-with-bg.svg',
          title: 'Card 5',
          text: 'This is an example of a page card component.',
          link_title: 'A link',
          link_url: '/curriculum'
        },
        {
          image_url: 'media/images/logos/tc-logo-with-bg.svg',
          title: 'Card 6',
          text: 'This is an example of a page card component.',
          link_title: 'A link',
          link_url: '/curriculum'
        }
      ]
    }

    render(PageCardComponent.new(params))
  end
end
