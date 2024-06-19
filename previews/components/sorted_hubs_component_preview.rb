class SortedHubsComponentPreview < ViewComponent::Preview
  def default
    location = "York"

    hubs_index = HubsIndex.new(location: location)

    render(SortedHubsComponent.new(sorted_hubs: hubs_index.sorted_hubs, formatted_address: hubs_index.formatted_address))
  end
end
