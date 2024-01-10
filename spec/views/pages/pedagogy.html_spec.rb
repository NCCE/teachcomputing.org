require "rails_helper"

RSpec.describe("pages/pedagogy", type: :view) do
  before do
    render
  end

  it "render a page title" do
    expect(rendered).to have_css(".hero__heading", text: "Promoting effective computing pedagogy")
  end

  context "when main page section" do
    it "renders correct number of sections" do
      expect(rendered).to have_css(".ways_to_teach__title", count: 12)
    end
  end

  context "when aside page section" do
    it "renders correct number of aside sections" do
      expect(rendered).to have_css(".report-card-component__title", count: 5)
    end
  end
end
