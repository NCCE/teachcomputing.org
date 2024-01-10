require "rails_helper"

RSpec.describe("pages/privacy", type: :view) do
  before do
    render
  end

  it "has a mailto stem link" do
    expect(rendered).to have_link("datasecurity@stem.org.uk", href: "mailto:datasecurity@stem.org.uk", count: 2)
  end

  it "has a mailto ncce link" do
    expect(rendered).to have_link("info@teachcomputing.org", href: "mailto:info@teachcomputing.org")
  end

  it "has the Google privacy link" do
    expect(rendered).to have_link("Read Google's overview of privacy and safeguarding data", href: "https://support.google.com/analytics/answer/6004245")
  end

  it "has the Twitter opt-out link" do
    expect(rendered).to have_link("How to opt out", href: "https://help.twitter.com/en/safety-and-security/privacy-controls-for-tailored-ads")
  end

  it "has the DfE form link" do
    expect(rendered).to have_link("DfE contact form", href: "https://form.education.gov.uk/service/Contact_the_Department_for_Education", count: 2)
  end
end
