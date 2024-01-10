class HubSearchComponentPreview < ViewComponent::Preview
  def default
    render(HubSearchComponent.new(location: nil))
  end

  def with_location
    render(HubSearchComponent.new(location: "cambridge"))
  end
end
