require "rails_helper"

RSpec.describe SortedHubsComponent, type: :component do
  # the distance method is added by the geocoder gem at runtime when running
  # geospatial queries. Using a verifying double here will not let us stub a
  # distance
  # rubocop:disable RSpec/VerifiedDoubles
  let(:hub) { double(Hub) }
  # rubocop:enable RSpec/VerifiedDoubles

  before do
    allow(hub).to receive(:distance).and_return(100)
    allow(hub).to receive(:satellite?).and_return(false)
    allow(hub).to receive_messages(attributes_for(:hub))
  end

  it "does not render when sorted_hubs is nil" do
    render_inline(described_class.new(sorted_hubs: nil, formatted_address: nil))
    expect(page).not_to have_css(".sorted-hubs-component__displaying")
  end

  it "renders formatted address" do
    render_inline(described_class.new(sorted_hubs: [hub], formatted_address: "Amazing place"))
    expect(page).to have_text("Displaying Hubs by distance from Amazing place")
  end

  it "has link to clear location" do
    render_inline(described_class.new(sorted_hubs: [hub], formatted_address: "Amazing place"))
    expect(page).to have_link("clear location", href: "/hubs")
  end

  context "when hub is satellite" do
    before do
      allow(hub).to receive(:satellite?).and_return(true)
    end

    it "renders satellite_info" do
      render_inline(described_class.new(sorted_hubs: [hub], formatted_address: nil))
      expect(page).to have_text(hub.satellite_info)
    end
  end
end
