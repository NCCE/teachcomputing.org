require "rails_helper"

RSpec.describe HeroComponent, type: :component do
  before do
    render_inline(described_class.new(title: "Page title", subtitle: "Subtitle of the page", status: "User status"))
  end

  it "renders the title" do
    expect(page).to have_text("Page title")
  end

  it "renders the subtitle" do
    expect(page).to have_text("Subtitle of the page")
  end

  it "renders the status" do
    expect(page).to have_text("User status")
  end
end
