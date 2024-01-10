require "rails_helper"

RSpec.describe HubsIndex do
  let(:hub_index) { described_class.new(location: location) }

  describe "#hub_regions" do
    let!(:regions) { create_list(:hub_region, 3) }

    context "when location is present" do
      let(:location) { "sheffield" }

      it "returns nil" do
        expect(hub_index.hub_regions).to eq(nil)
      end
    end

    context "when location is not present" do
      let(:location) { nil }

      it "returns hub regions" do
        expect(hub_index.hub_regions).to match_array(regions)
      end
    end
  end

  describe "#current_location" do
    context "when location is present" do
      let(:location) { "sheffield" }

      it "returns correctly" do
        expect(hub_index.current_location).to eq("sheffield")
      end
    end

    context "when location is not present" do
      let(:location) { nil }

      it "returns nil" do
        expect(hub_index.current_location).to eq(nil)
      end
    end
  end

  describe "#sorted_hubs" do
    let!(:hubs) { create_list(:hub, 4) }

    context "when location is not present" do
      let(:location) { nil }

      it "returns nil" do
        expect(hub_index.sorted_hubs).to eq(nil)
      end
    end

    context "when no results found" do
      let(:location) { "invalid" }

      it "returns nil" do
        expect(hub_index.sorted_hubs).to eq(nil)
      end
    end

    context "when location is present" do
      let(:location) { "sheffield" }

      it "returns hubs" do
        expect(hub_index.sorted_hubs).to match_array(hubs)
      end

      it "calls the ordering method correctly" do
        allow(Hub).to receive(:near)
        hub_index.sorted_hubs
        expect(Hub).to have_received(:near).with([53.4000000, -1.500000], 500)
      end
    end
  end

  describe "#formatted_address" do
    let(:location) { "sheffield" }

    it "calls format_address method on Geocoding class" do
      result_dbl = instance_double("result")
      allow(Geocoder).to receive(:search) { [result_dbl] }
      allow(Geocoding).to receive(:format_address)
      hub_index.formatted_address
      expect(Geocoding).to have_received(:format_address).with(geocoded_location: result_dbl)
    end
  end
end
