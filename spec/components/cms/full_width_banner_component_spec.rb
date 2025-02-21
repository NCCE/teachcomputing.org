# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cms::FullWidthBannerComponent, type: :component do
  context "standard layout" do
    before do
      render_inline(described_class.new(
        text_content: Cms::Mocks::RichBlocks.as_model,
        image: Cms::Mocks::Image.as_model,
        image_side: :left,
        image_link: "https://www.teachcomputing.test/test-page",
        title: nil,
        background_color: "light-grey"
      ))
    end

    it "renders background color" do
      expect(page).to have_css(".cms-full-width-banner-row.light-grey-bg")
    end

    it "renders the intro text" do
      expect(page).to have_css(".cms-rich-text-block-component")
    end

    it "should have image" do
      expect(page).to have_css("img")
    end

    it "should have link" do
      expect(page).to have_link(href: "https://www.teachcomputing.test/test-page")
    end
  end

  context "with heading" do
    let(:title) { Faker::Lorem.sentence }

    before do
      render_inline(described_class.new(
        text_content: Cms::Mocks::RichBlocks.as_model,
        image: Cms::Mocks::Image.as_model,
        image_side: :left,
        image_link: nil,
        title:
      ))
    end

    it "show render heading" do
      expect(page).to have_css(".govuk-heading-l.cms-full-width-banner__heading", text: title)
    end
  end

  context "with border" do
    before do
      render_inline(described_class.new(
        text_content: Cms::Mocks::RichBlocks.as_model,
        image: Cms::Mocks::Image.as_model,
        image_side: :left,
        image_link: nil,
        title: nil,
        show_bottom_border: true
      ))
    end

    it "show render heading" do
      expect(page).to have_css(".cms-full-width-banner-row.has-border")
    end
  end

  context "with buttons" do
    before do
      render_inline(described_class.new(
        text_content: Cms::Mocks::RichBlocks.as_model,
        image: Cms::Mocks::Image.as_model,
        image_side: :left,
        image_link: nil,
        title: nil,
        show_bottom_border: true,
        buttons: [Cms::Mocks::NcceButton.as_model]
      ))
    end

    it "show render button" do
      expect(page).to have_css(".govuk-button")
    end
  end
end
