require "rails_helper"

RSpec.describe("pages/secondary-early-careers") do
  before do
    render
  end

  it "has a title" do
    expect(rendered).to have_css(".hero__text", text: "We support early career and trainee teachers to develop their computing subject knowledge and pedagogy through professional development, resources and local communities.")
  end

  it "has a hero heading" do
    expect(rendered).to have_css(".govuk-heading-xl", text: "Secondary early career and trainee teachers")
  end

  it "has a Professional development section" do
    expect(rendered).to have_css(".govuk-heading-l", text: "Professional development")
  end

  it "has a Develop your teaching practice section" do
    expect(rendered).to have_css(".govuk-heading-l", text: "Develop your teaching practice")
  end

  it "has a funding section" do
    expect(rendered).to have_css(".govuk-heading-s", text: "Funding")
  end

  it "has a Resources section" do
    expect(rendered).to have_css(".govuk-heading-xl", text: "Resources")
  end

  it "has three resources cards" do
    expect(rendered).to have_css(".card", count: 3)
  end

  it "has a Communities section" do
    expect(rendered).to have_css(".govuk-heading-xl", text: "Communities")
  end

  it "has three community cards" do
    expect(rendered).to have_css(".non-bordered-card", count: 3)
  end
end
