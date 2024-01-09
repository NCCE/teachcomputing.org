require "rails_helper"

RSpec.describe("pages/certification/_pathway", type: :view) do
  let(:programme) { create(:cs_accelerator) }

  before do
    @programme = programme
  end

  it "has the title" do
    render
    expect(rendered).to have_css(".govuk-heading-s", text: "Choose a pathway")
  end

  it "renders pathways from database" do
    pathway1 = create(:pathway, programme: programme)
    pathway2 = create(:pathway, programme: programme)
    render
    expect(rendered).to have_css(".pathway__item", count: 2)
    expect(rendered).to have_text(pathway1.title)
    expect(rendered).to have_text(pathway2.title)
  end

  it "has a courses button" do
    render
    expect(rendered).to have_css(".button", text: "Browse our courses")
  end
end
