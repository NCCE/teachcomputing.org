require 'rails_helper'

RSpec.describe Hub, type: :model do
  it { is_expected.to belong_to(:hub_region) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:subdeliverer_id) }

  describe 'geocodable_address' do
    it 'returns address with postcode appended' do
      hub = build(:hub, address: '123 Fake Street', postcode: 'S1 1SS')
      expect(hub.geocodable_address).to eq('123 Fake Street, S1 1SS')
    end
  end
end
