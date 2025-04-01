# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cms::TwoColumnPictureSectionComponent, type: :component do
  context "with standard layout" do
    before do
      render_inline(described_class.new(
        text: Cms::Mocks::RichBlocks.as_model,
        image: Cms::Mocks::ImageComponents::Image.as_model,
        image_side: "left",
        background_color: nil
      ))
    end

    it "renders the rich text" do
      expect(page).to have_css(".cms-rich-text-block-component")
    end

    it "renders the image" do
      expect(page).to have_css("img")
    end

    it "renders the image on the left" do
      expect(page).to_not have_css(".cms-two-column-picture-section-component--right-align")
    end

    it "doesnt apply background color class when not present" do
      expect(page).not_to have_css("[class$='-bg']")
    end
  end

  context "with right side image layout" do
    before do
      render_inline(described_class.new(
        text: Cms::Mocks::RichBlocks.as_model,
        image: Cms::Mocks::ImageComponents::Image.as_model,
        image_side: "right",
        background_color: nil
      ))
    end

    it "renders the image on the right" do
      expect(page).to have_css(".cms-two-column-picture-section-component--right-align")
    end
  end

  context "with background color" do
    before do
      render_inline(described_class.new(
        text: Cms::Mocks::RichBlocks.as_model,
        image: Cms::Mocks::ImageComponents::Image.as_model,
        image_side: "left",
        background_color: "orange"
      ))
    end

    it "renders the image on the right" do
      expect(page).to have_css(".orange-bg")
    end
  end
end
