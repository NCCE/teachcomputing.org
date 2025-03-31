# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cms::VideoCardComponent, type: :component do
  let(:video) { "https://static.teachcomputing.org/How_important_is_the_I_Belong_programme.mp4" }

  context "standard layout" do
    before do
      render_inline(described_class.new(
        video: Cms::Mocks::DynamicComponents::ContentBlocks::EmbeddedVideo.as_model,
        title: "Card title",
        name: "John Smith",
        job_title: "Head of IT",
        text_content: Cms::Mocks::RichBlocks.as_model,
        color_theme: "standard"
      ))
    end

    it "renders the video" do
      expect(page).to have_css("video[src='#{video}']")
    end

    it "renders the title" do
      expect(page).to have_text("Card title")
    end

    it "renders the icons" do
      expect(page).to have_css(".cms-video-card-component__icon", count: 2)
    end

    it "renders the name" do
      expect(page).to have_text("John Smith")
    end

    it "renders the job title" do
      expect(page).to have_text("Head of IT")
    end

    it "renders the rich text component" do
      expect(page).to have_css(".cms-rich-text-block-component")
    end

    it "renders the color theme class" do
      expect(page).to have_css(".cms-color-theme__border--standard-top")
    end
  end

  context "with no name job title or color theme" do
    before do
      render_inline(described_class.new(
        video: Cms::Mocks::DynamicComponents::ContentBlocks::EmbeddedVideo.as_model,
        title: "Card title",
        name: nil,
        job_title: nil,
        text_content: Cms::Mocks::RichBlocks.as_model,
        color_theme: nil
      ))
    end

    it "does not render the name and job title sections" do
      expect(page).to_not have_css(".cms-video-card-component__icon-wrapper")
    end

    it "does not have a color theme class" do
      expect(page).to_not have_css(".cms-color-theme__border--standard-top")
    end
  end
end
