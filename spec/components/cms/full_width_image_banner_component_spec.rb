# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cms::FullWidthImageBannerComponent, type: :component do
  let(:overlay_title) { Faker::Lorem.sentence }
  let(:background_image) { Cms::Mocks::ImageComponents::Image.as_model }

  context "right side overlay" do
    before do
      render_inline(described_class.new(
        overlay_title:,
        background_image:,
        overlay_icon: Cms::Mocks::ImageComponents::Image.as_model,
        overlay_text: Cms::Mocks::RichBlocks.as_model,
        overlay_side: "right"
      ))
    end

    it "should render the component" do
      expect(page).to have_css(".cms-full-width-image-banner")
    end

    it "should render overlay title as h3" do
      expect(page).to have_css("h3", text: overlay_title)
    end

    it "should add background image url to banner" do
      expect(page).to have_css(".cms-full-width-image-banner[style*='background-image: url(#{background_image.image_url}']")
    end

    it "should render body text" do
      expect(page).to have_css(".cms-rich-text-block-component")
    end

    it "should render the overlay" do
      expect(page).to have_css(".cms-full-width-image-banner__overlay--right")
    end
  end

  context "left side overlay" do
    before do
      render_inline(described_class.new(
        overlay_title:,
        background_image: Cms::Mocks::ImageComponents::Image.as_model,
        overlay_icon: Cms::Mocks::ImageComponents::Image.as_model,
        overlay_text: Cms::Mocks::RichBlocks.as_model,
        overlay_side: "left"
      ))
    end

    it "should render the component" do
      expect(page).to have_css(".cms-full-width-image-banner")
    end

    it "should render the overlay" do
      expect(page).to have_css(".cms-full-width-image-banner__overlay--left")
    end
  end

  context "no overlay" do
    before do
      render_inline(described_class.new(
        overlay_title: nil,
        background_image: Cms::Mocks::ImageComponents::Image.as_model,
        overlay_icon: nil,
        overlay_text: nil,
        overlay_side: "left"
      ))
    end

    it "should render the component" do
      expect(page).to have_css(".cms-full-width-image-banner")
    end

    it "should not render the overlay" do
      expect(page).not_to have_css(".cms-full-width-image-banner__overlay--left")
    end
  end
end
