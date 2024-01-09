require "rails_helper"

RSpec.describe("pages/accessibility-statement", type: :view) do
  before do
    render
  end

  it "has a title" do
    render
    expect(rendered).to have_css(".govuk-heading-xl", text: "Accessibility statement")
  end

  it "has three subtitles" do
    expect(rendered).to have_css(".govuk-heading-s", count: 3)
  end

  it "has a contact link" do
    expect(rendered).to have_link("info@teachcomputing.org", href: "mailto:info@teachcomputing.org")
  end
end
