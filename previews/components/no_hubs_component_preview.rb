class NoHubsComponentPreview < ViewComponent::Preview
  def default
    render(NoHubsComponent.new(hub_regions: [], sorted_hubs: []))
  end
end
