require "rails_helper"

RSpec.describe("pages/careers-support", type: :view) do
  before do
    render
  end

  it "has a title" do
    expect(rendered).to have_css(".govuk-heading-l", text: "Where next? Careers in computing, technology and digita")
  end

  it "has two testimonials" do
    expect(rendered).to have_css(".testimonial", count: 2)
  end

  it "has six benchmark cards" do
    expect(rendered).to have_css(".benchmark-bordered-card", count: 6)
  end
end
