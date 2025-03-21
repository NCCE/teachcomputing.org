# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cms::HorizontalLinkCardComponent, type: :component do
  before do
    render_inline(described_class.new(
      title: "Primary certificate",
      card_content: Cms::Mocks::RichBlocks.as_model,
      link_url: "/primary-certificate",
      theme: "standard"
    ))
  end

  it "should render wrapper" do
    expect(page).to have_css(".cms-horizontal-link-card")
  end

  it "should render title as link" do
    expect(page).to have_link("Primary certificate", href: "/primary-certificate")
  end

  it "should add theme classes" do
    expect(page).to have_css(".cms-color-theme__border--standard-left")
    expect(page).to have_css(".standard-theme")
  end

  it "should render card content" do
    expect(page).to have_css(".cms-rich-text-block-component")
  end
end
