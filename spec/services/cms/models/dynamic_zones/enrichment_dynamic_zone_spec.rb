require "rails_helper"

RSpec.describe Cms::Models::DynamicZones::EnrichmentDynamicZone do
  it "should render a Cms::DynamicZoneComponent" do
    @dynamic_zone = described_class.new(cms_models: [
      Cms::Mocks::DynamicComponents::Blocks::FullWidthText.as_model
    ])
    expect(@dynamic_zone.render).to be_instance_of(Cms::DynamicZoneComponent)
  end
end
