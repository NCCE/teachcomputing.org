require "rails_helper"

RSpec.describe("pages/get-involved", type: :view) do
  include ExternalLinkHelper
  include CmsLinkHelper

  before do
    render
  end

  it "has a title" do
    expect(rendered).to have_css(".hero__heading", text: "Play your part in inspiring the next generation")
  end

  it "has an intro section" do
    expect(rendered).to have_css(".govuk-body-m", text: "We are dedicated to ensuring every child in England receives high-quality computing education")
    expect(rendered).to have_css(".govuk-heading-s", text: "Demand is growing")
  end

  it "has an ambassador section" do
    expect(rendered).to have_css(".govuk-heading-m", text: "Become a volunteer and then shout about it!")
    expect(rendered).to have_link("STEM Ambassador", href: stem_ambassadors_url)
  end

  it "has a governor section" do
    expect(rendered).to have_css(".govuk-heading-m", text: "Be an advocate for education")
    expect(rendered).to have_link("Think about becoming a governor", href: governors_and_trustees_url)
  end

  it "has a video for both ambassador and governor sections" do
    expect(rendered).to have_css(".banner-component__media-section", count: 2)
  end

  it "has a get in touch section" do
    expect(rendered).to have_css(".govuk-heading-m", text: "Deliver social value through investing in improving young people’s life outcomes")
    expect(rendered).to have_link("Get in touch", href: governors_and_trustees_url)
  end

  it "has a get involved section" do
    expect(rendered).to have_css(".govuk-heading-s", text: "Making an impact today")
  end

  it "has a testimonials section" do
    expect(rendered).to have_css(".get-involved_key-points")
  end

  it "has key points sections" do
    expect(rendered).to have_css(".testimonial")
  end

  it "has an impact report section" do
    expect(rendered).to have_link("View our latest Impact report", href: impact_report_url)
    expect(rendered).to have_link("Discover more of our impact", href: impact_path)
  end

  it "has a join us section" do
    expect(rendered).to have_css(".govuk-heading-m", text: "We encourage all government departments and public services to join us and support our work")
  end
end
