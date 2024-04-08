require "rails_helper"

RSpec.describe IsaacCardComponent, type: :component do
  before do
    render_inline(described_class.new(tracking_category: "test"))
  end

  it "has the expected bg" do
    expect(page).to have_css(".isaac-bg")
  end

  it "renders the isaac logo" do
    expect(page).to have_css("img[src*='isaac-logo']")
  end

  it "renders the body text" do
    expect(page).to have_css(".govuk-body", text: "Isaac Computer Science is our free online digital textbook")
  end

  it "renders an A Level link" do
    expect(page).to have_link("A level", href: "/a-level-computer-science")
  end
  it "renders a GCSE link" do
    expect(page).to have_link("GCSE computer science", href: "/gcse-revision")
  end
end
