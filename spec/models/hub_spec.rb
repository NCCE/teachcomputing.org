require "rails_helper"

RSpec.describe Hub, type: :model do
  it { is_expected.to belong_to(:hub_region) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:subdeliverer_id) }

  describe "#geocodable_address" do
    it "returns address with postcode appended" do
      hub = build(:hub, address: "123 Fake Street", postcode: "S1 1SS")
      expect(hub.geocodable_address).to eq("123 Fake Street, S1 1SS")
    end

    it "returns postcode only if address is nil" do
      hub = build(:hub, address: nil, postcode: "S1 1SS")
      expect(hub.geocodable_address).to eq("S1 1SS")
    end
  end

  describe "#needs_geocoding?" do
    let(:new_hub) { build(:hub, address: nil, postcode: nil) }
    it "returns true if only postcode present" do
      new_hub.postcode = "S1 1SS"
      expect(new_hub.needs_geocoding?).to eq(true)
    end

    it "returns false if postcode not present" do
      new_hub.address = "Lovely address"
      expect(new_hub.needs_geocoding?).to eq(false)
    end

    it "returns true if postcode and address are present" do
      new_hub.postcode = "S1 1SS"
      new_hub.address = "Lovely address"
      expect(new_hub.needs_geocoding?).to eq(true)
    end

    context "on persisted instance" do
      let(:persisted_hub) { create(:hub, address: "Old address", postcode: "S1 1SS") }

      it "returns false if postcode and address have not changed" do
        expect(persisted_hub.needs_geocoding?).to eq(false)
      end

      it "returns true if postcode has changed" do
        persisted_hub.postcode = "S2 2SS"
        expect(persisted_hub.needs_geocoding?).to eq(true)
      end

      it "returns true if address has changed" do
        persisted_hub.address = "New addresss"
        expect(persisted_hub.needs_geocoding?).to eq(true)
      end
    end
  end
end
