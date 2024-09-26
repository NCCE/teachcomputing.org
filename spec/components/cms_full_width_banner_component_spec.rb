# frozen_string_literal: true

require "rails_helper"

RSpec.describe CmsFullWidthBannerComponent, type: :component do
  context "standard layout" do
    before do
      render_inline(described_class.new(
        text_content: Cms::Mocks::RichBlocks.as_model,
        image: Cms::Mocks::Image.as_model,
        image_side: :left,
        image_link: nil,
        title: nil
      ))
    end

    it "renders the intro text" do
      expect(page).to have_css(".cms-rich-text-block-component")
    end

    it "should have image" do
      expect(page).to have_css("img")
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
end
