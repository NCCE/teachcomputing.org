require "rails_helper"

RSpec.describe HubComponent, type: :component do
  let(:hub) { build(:hub) }

  it "shows hub name" do
    render_inline(described_class.new(hub: hub))
    expect(page).to have_css(".hub-component__heading", text: hub.name)
  end

  context "when hub is not a satellite" do
    it "shows address and postcode" do
      render_inline(described_class.new(hub: hub))
      expect(page).to have_text(hub.address)
      expect(page).to have_text(hub.postcode)
    end
  end

  context "when hub is satellite" do
    let(:hub) { build(:hub, address: nil, postcode: nil, satellite: true) }

    it "shows satellite_info" do
      render_inline(described_class.new(hub: hub))
      expect(page)
        .to have_text(hub.satellite_info)
    end
  end
end
