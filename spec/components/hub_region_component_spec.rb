require "rails_helper"

RSpec.describe HubRegionComponent, type: :component do
  let(:hub_region) { build(:hub_region) }

  it "shows name" do
    render_inline(described_class.new(hub_region:))
    expect(page).to have_text(hub_region.name)
  end
end
