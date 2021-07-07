class HubRegionComponentPreview < ViewComponent::Preview
  def default
    hub_region = FactoryBot.build(
      :hub_region,
      hubs: FactoryBot.build_list(
        :hub, 2
      )
    )
    render(HubRegionComponent.new(hub_region: hub_region))
  end
end
