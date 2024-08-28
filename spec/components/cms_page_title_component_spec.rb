# frozen_string_literal: true

require "rails_helper"

RSpec.describe CmsPageTitleComponent, type: :component do
  before do
    render_inline(described_class.new(title: "Page title", intro_text: "Intro text for the page"))
  end

  it "renders the title" do
    expect(page).to have_text("Page title")
  end

  it "renders the intro text" do
    expect(page).to have_text("Intro text for the page")
  end
end
