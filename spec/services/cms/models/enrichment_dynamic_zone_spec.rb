require "rails_helper"

RSpec.describe Cms::Models::EnrichmentDynamicZone do
  it "should render a CmsDynamicZoneComponent" do
    @dynamic_zone = described_class.new(cms_models: [
      Cms::Mocks::FullWidthText.as_model
    ])
    expect(@dynamic_zone.render).to be_instance_of(CmsDynamicZoneComponent)
  end
end
