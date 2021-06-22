require "rails_helper"

RSpec.describe HubComponent, type: :component do
  let(:hub) { build(:hub) }

  it 'shows hub name' do
    render_inline(described_class.new(hub: hub))
    expect(rendered_component).to have_css('.hub-component__heading', text: hub.name)
  end

  context 'when address and postcode are present' do
    it 'shows address and postcode' do
      render_inline(described_class.new(hub: hub))
      expect(rendered_component).to include(hub.address)
      expect(rendered_component).to include(hub.postcode)
    end
  end

  context 'when address and postcode are nil' do
    let(:hub) { build(:hub, address: nil, postcode: nil) }
    it 'shows no address message' do
      render_inline(described_class.new(hub: hub))
      expect(rendered_component)
        .to include('We are currently setting up a venue for this hub' )
    end
  end
end
