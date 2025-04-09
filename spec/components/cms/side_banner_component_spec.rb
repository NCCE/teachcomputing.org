# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cms::SideBannerComponent, type: :component do

  context "with defaults" do
    before do
      render_inline(described_class.new(
        text_content: Cms::Mocks::Text::RichBlocks.as_model,
        icon: nil,
        banner_color: nil
      ))
    end

    it "should set background color to white" do
      expect(page).to have_css(".cms-side-banner.white-bg")
    end

    it "should not render image" do
      expect(page).not_to have_css(".cms-side-banner__icon")
    end

    it "should default to right" do
      expect(page).to have_css(".cms-side-banner--right")
    end
  end

  context "with left side and banner color" do
    before do
      render_inline(described_class.new(
        text_content: Cms::Mocks::Text::RichBlocks.as_model,
        icon: nil,
        banner_color: "orange",
        side: "left"
      ))
    end

    it "should set background color class" do
      expect(page).to have_css(".cms-side-banner.orange-bg")
    end

    it "should not render image" do
      expect(page).not_to have_css(".cms-side-banner__icon")
    end

    it "should default to right" do
      expect(page).to have_css(".cms-side-banner--left")
    end
  end

  context "with icon" do
    before do
      render_inline(described_class.new(
        text_content: Cms::Mocks::Text::RichBlocks.as_model,
        icon: Cms::Mocks::Images::Image.as_model,
      ))
    end

    it "should render image" do
      expect(page).to have_css(".cms-side-banner__icon")
      expect(page).to have_css(".cms-image")
    end
  end
end
