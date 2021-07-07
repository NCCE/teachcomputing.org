class HubSocialLinkComponentPreview < ViewComponent::Preview
  def website
    render(HubSocialLinkComponent.new(type: 'website', value: 'http://example.com'))
  end

  def facebook
    render(HubSocialLinkComponent.new(type: 'facebook', value: 'fakebookaccount'))
  end

  def twitter
    render(HubSocialLinkComponent.new(type: 'twitter', value: 'faketwitaccount'))
  end
end
