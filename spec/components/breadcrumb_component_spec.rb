require "rails_helper"

RSpec.describe BreadcrumbComponent, type: :component do
  let(:ancestors) {
    [
      ["google", "https://www.google.com"],
      ["facebook", "https://www.facebook.com"]
    ]
  }
  let(:current_page_name) { "nasa" }

  before do
    render_inline(described_class.new(ancestors:, current_page_name:))
  end

  it "renders out the ancestor links" do
    expect(page).to have_link("https://www.google.com")
    expect(page).to have_link("https://www.facebook.com")
  end

  it "renders out chevrons" do
    expect(page).to have_text(">").twice
  end

  it "should have current page name" do
    expect(page).to have_text("nasa")
  end
end
