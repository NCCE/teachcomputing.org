# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cms::TwoColumnVideoSectionComponent, type: :component do
  context "with standard layout" do
    before do
      render_inline(described_class.new(
        left_column_content: Cms::Mocks::RichBlocks.as_model,
        video: Cms::Mocks::DynamicComponents::EmbeddedVideo.as_model
      ))
    end

    it "renders the component" do
      expect(page).to have_css(".cms-two-column-video-section-component")
    end

    it "renders the left column content" do
      expect(page).to have_css(".cms-rich-text-block-component", count: 1)
    end

    it "renders the embedded video" do
      expect(page).to have_css("video")
    end
  end

  context "with left and right column content" do
    before do
      render_inline(described_class.new(
        left_column_content: Cms::Mocks::RichBlocks.as_model,
        right_column_content: Cms::Mocks::RichBlocks.as_model,
        video: Cms::Mocks::DynamicComponents::EmbeddedVideo.as_model
      ))
    end

    it "renders the content" do
      expect(page).to have_css(".cms-rich-text-block-component", count: 2)
    end
  end

  context "with light background color" do
    before do
      render_inline(described_class.new(
        left_column_content: Cms::Mocks::RichBlocks.as_model,
        video: Cms::Mocks::DynamicComponents::EmbeddedVideo.as_model,
        background_color: "light-grey"
      ))
    end

    it "has background color" do
      expect(page).to have_css(".light-grey-bg")
    end
  end

  context "with yellow background color" do
    before do
      render_inline(described_class.new(
        left_column_content: Cms::Mocks::RichBlocks.as_model,
        video: Cms::Mocks::DynamicComponents::EmbeddedVideo.as_model,
        background_color: "isaac"
      ))
    end

    it "has white background color for content" do
      expect(page).to have_css(".cms-two-column-video-section-component--wrapper__white")
    end
  end

  context "with ncce button" do
    before do
      render_inline(described_class.new(
        left_column_content: Cms::Mocks::RichBlocks.as_model,
        video: Cms::Mocks::DynamicComponents::EmbeddedVideo.as_model,
        left_column_button: Cms::Mocks::NcceButton.as_model
      ))
    end

    it "renders the ncce button" do
      expect(page).to have_css(".govuk-button")
    end
  end
end
