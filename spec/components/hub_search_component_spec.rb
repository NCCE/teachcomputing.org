require "rails_helper"

RSpec.describe HubSearchComponent, type: :component do
  it "shows location if present" do
    render_inline(described_class.new(location: "sheffield"))
    expect(page).to have_field(:location, with: "sheffield")
  end

  it "shows placeholder if no location" do
    render_inline(described_class.new(location: nil))
    expect(page).to have_field(:location, placeholder: "Town, city or postcode")
  end
end
