class HubComponentPreview < ViewComponent::Preview
  def standard_hub
    hub = FactoryBot.build(:hub)
    render(HubComponent.new(hub: hub))
  end

  def satellite_hub
    hub = FactoryBot.build(:hub, satellite: true)
    render(HubComponent.new(hub: hub))
  end
end
