require "rails_helper"

RSpec.describe BursaryComponent, type: :component do
  it "has a title" do
    render_inline(described_class.new)
    expect(page).to have_css(".bursary-component__title", text: "Funding")
  end

  it "renders a link" do
    render_inline(described_class.new)
    expect(page).to have_link("Funding information", href: "/funding")
  end

  it "renders a bottom margin" do
    render_inline(described_class.new)
    expect(page).not_to have_css(".bursary-component--no-margin")
  end

  it "adds data attributes when passed" do
    render_inline(described_class.new(tracking_event_category: "category", tracking_event_label: "label"))
    expect(page).to have_selector("a[href='/funding'][data-event-category='category']")
    expect(page).to have_selector("a[href='/funding'][data-event-label='label']")
    expect(page).to have_selector("a[href='/funding'][data-event-action='click']")
  end

  context "when we set the no_margin flag" do
    it "does not render a bottom margin" do
      render_inline(described_class.new(bottom_margin: false))
      expect(page).to have_css(".bursary-component--no-margin")
    end
  end
end
