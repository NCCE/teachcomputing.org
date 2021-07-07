require 'rails_helper'

RSpec.describe HubRegionComponent, type: :component do
  let(:hub_region) { build(:hub_region) }

  it 'shows name' do
    render_inline(described_class.new(hub_region: hub_region))
    expect(rendered_component).to include(hub_region.name)
  end
end
