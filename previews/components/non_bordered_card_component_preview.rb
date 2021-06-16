class NonBorderedCardComponentPreview < ViewComponent::Preview
  def card_with_image
    params = {
      image_url: 'media/images/logos/tc-logo-with-bg.svg',
      title: 'Card 1',
      text: 'This is an example of a page card component.',
      link_title: 'A link',
      link_url: '/curriculum'
    }

    render(NonBorderedCardComponent.new(params))
  end

  def card_no_image
    params = {
      image_url: nil,
      title: 'Card 1',
      text: 'This is an example of a page card component.',
      link_title: 'A link',
      link_url: '/curriculum'
    }

    render(NonBorderedCardComponent.new(params))
  end
end
