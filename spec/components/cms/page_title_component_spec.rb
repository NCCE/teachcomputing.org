# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cms::PageTitleComponent, type: :component do
  context "Without Media" do
    before do
      render_inline(described_class.new(title: "Page title", sub_text: "Sub text for the page"))
    end

    it "renders the title" do
      expect(page).to have_text("Page title")
    end

    it "renders the sub text" do
      expect(page).to have_text("Sub text for the page")
    end

    it "doesnt render the media section when non present" do
      expect(page).not_to have_css(".page-title__media")
    end

    it "doesnt render status_message container when non present" do
      expect(page).not_to have_css(".page-title__status-message")
    end
  end

  context "With Media" do
    before do
      render_inline(described_class.new(title: "Page title", sub_text: "Sub text for the page", title_image: Cms::Mocks::Image.as_model))
    end

    it "renders the title" do
      expect(page).to have_text("Page title")
    end

    it "renders the sub text" do
      expect(page).to have_text("Sub text for the page")
    end

    it "renders the media section when present" do
      expect(page).to have_css(".page-title__media")
    end

    it "renders the image" do
      expect(page).to have_css(".cms-image img")
    end
  end

  context "With video" do
    before do
      render_inline(described_class.new(title: "Page title", sub_text: "Sub text for the page", title_image: Cms::Mocks::Image.as_model, title_video_url: "https://www.youtube.com/watch?v=aYYcHSESJxo"))
    end

    it "renders the title" do
      expect(page).to have_text("Page title")
    end

    it "renders the sub text" do
      expect(page).to have_text("Sub text for the page")
    end

    it "renders the media--video section when present" do
      expect(page).to have_css(".page-title__media--video")
    end

    it "does not render the image when video given" do
      expect(page).not_to have_css(".cms-image img")
    end
  end

  context "With status message" do
    before do
      render_inline(described_class.new(title: "Page title", status_message: "You completed"))
    end

    it "renders the title" do
      expect(page).to have_text("Page title")
    end

    it "render status_message container" do
      expect(page).to have_css(".page-title__status-message", text: "You completed")
    end
  end
end
