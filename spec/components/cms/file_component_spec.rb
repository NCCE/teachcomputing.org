# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cms::FileComponent, type: :component do
  let(:updated_at) { DateTime.new(2024, 8, 9) }
  let(:file) {
    Cms::DynamicComponents::ContentBlocks::FileLink.new(
      url: "https://strapi.teachcomputing.org/test_file.pdf",
      filename: "Test File",
      size: 45,
      updated_at:
    )
  }

  before do
    render_inline(described_class.new(file:))
  end

  it "should render wrapper" do
    expect(page).to have_css(".cms-file")
  end

  it "renders link to file" do
    expect(page).to have_link("Test File", href: "https://strapi.teachcomputing.org/test_file.pdf")
  end

  it "renders the extension" do
    expect(page).to have_text("(PDF, ")
  end

  it "renders updated time" do
    expect(page).to have_text("Updated: 09 Aug 2024")
  end
end
