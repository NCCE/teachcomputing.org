require "rails_helper"

RSpec.describe Geocoding do
  describe ".format_address(geocoded_location: geocoded_location_dbl)" do
    let(:geocoded_location_dbl) { instance_double("geocoded_location") }

    context "when geocoded location is found" do
      it "returns the postal_town component if present from geocoding result" do
        allow(geocoded_location_dbl)
          .to receive(:address_components)
          .and_return([
            {"long_name" => "Liverpool",
             "short_name" => "Liverpool", "types" => ["postal_town"]}
          ])
        expect(described_class.format_address(geocoded_location: geocoded_location_dbl)).to eq("Liverpool")
      end

      it "returns the formatted address if no postal_town component" do
        allow(geocoded_location_dbl).to receive(:address_components).and_return([])
        allow(geocoded_location_dbl).to receive(:formatted_address).and_return("Liverpool, UK")
        expect(described_class.format_address(geocoded_location: geocoded_location_dbl)).to eq("Liverpool, UK")
      end
    end

    context "when geocoded location is not found" do
      it "returns nil" do
        expect(described_class.format_address(geocoded_location: nil)).to eq(nil)
      end
    end
  end
end
