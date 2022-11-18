class ProviderLogosComponentPreview < ViewComponent::Preview
  def default
    render(ProviderLogosComponent.new(online: true))
  end
end
