require "rails_helper"

RSpec.describe("pages/secondary-question-banks") do
  before do
    render
  end

  it "has a hero heading" do
    expect(rendered).to have_css(".govuk-heading-xl", text: "Secondary question banks")
  end

  it "has a how to aside section" do
    expect(rendered).to have_css(".ncce-aside")
  end

  it "has a topics section" do
    expect(rendered).to have_css(".govuk-heading-m", text: "Topics")
  end

  it "has 10 question bank resources list" do
    expect(rendered).to have_css(".curriculum__list--item", count: 10)
  end

  it "has a feedback section" do
    expect(rendered).to have_css(".govuk-heading-m", text: "Help us make these resources better")
  end
end
