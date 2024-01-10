require "rails_helper"

RSpec.describe("pages/careers-week", type: :view) do
  it "has a title" do
    render
    expect(rendered).to have_css(".govuk-heading-l", text: "Careers in computing")
  end

  it "has six testimonials" do
    render
    expect(rendered).to have_css(".careers-week__testimonials>div", count: 8)
  end
end
