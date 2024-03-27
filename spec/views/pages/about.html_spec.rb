require "rails_helper"

RSpec.describe("pages/about", type: :view) do
  before do
    render
  end

  it "has an introduction" do
    expect(rendered).to have_css(".govuk-body-l", text: "The National Centre for Computing Education (NCCE) is funded")
  end

  it "has the expected links in the introduction" do
    expect(rendered).to have_link("STEM Learning", href: "https://www.stem.org.uk/")
    expect(rendered).to have_link("Discover our teaching resources", href: "/curriculum")
    expect(rendered).to have_link("Explore our A level resources", href: "/a-level-computer-science")
    expect(rendered).to have_link("Visit Computing Quality Framework", href: "https://computingqualityframework.org/")
  end

  it "has an ambition section" do
    expect(rendered).to have_css(".govuk-heading-l", text: "Our ambition")
  end

  it "has the expected links in the ambition section" do
    expect(rendered).to have_link("Impact and evaluation", href: "/impact-and-evaluation")
  end

  it "has a diversity section" do
    expect(rendered).to have_css(".govuk-heading-l", text: "Diversity and inclusion")
  end

  it "has an offer section" do
    expect(rendered).to have_css(".govuk-heading-l", text: "Our offer")
  end

  it "has the expected links in the offer section" do
    expect(rendered).to have_link("resources", href: "/curriculum")
    expect(rendered).to have_link("training courses", href: "/courses")
    expect(rendered).to have_link("Funding is available", href: "/funding")
    expect(rendered).to have_link("Primary teachers toolkit", href: "/primary-teachers")
    expect(rendered).to have_link("Secondary teachers toolkit", href: "/secondary-teachers")
  end

  it "has a support section" do
    expect(rendered).to have_css(".govuk-heading-l", text: "How you can support our work")
  end

  it "has the expected links in the support section" do
    expect(rendered).to have_link("Support us", href: "/supporting-partners")
    expect(rendered).to have_link("How you can help", href: "/get-involved")
    expect(rendered).to have_link("Meet our partners", href: "/contributing-partners")
    expect(rendered).to have_link("Advocate for us", href: "/governors-and-trustees/")
  end
end
