# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cms::ResourceCardComponent, type: :component do
  let(:body_text) { Cms::Mocks::RichBlocks.as_model }

  context "has all the values defined" do
    before do
      render_inline(described_class.new(
        title: "Card Title",
        icon: Cms::Mocks::ImageComponents::Image.as_model,
        color_theme: "standard",
        body_text: body_text,
        button_text: "Click here",
        button_link: "https://www.example.com"
      ))
    end

    it "renders a title" do
      expect(page).to have_text("Card Title")
    end

    it "renders an icon" do
      expect(page).to have_css("img")
    end

    it "renders a color theme" do
      expect(page).to have_css(".cms-color-theme__border--standard-top")
    end

    it "renders the body text" do
      expect(page).to have_css(".cms-rich-text-block-component")
    end

    it "renders a button with a link" do
      expect(page).to have_link("Click here", href: "https://www.example.com")
    end
  end

  context "has only the required values" do
    before do
      render_inline(described_class.new(
        title: nil,
        icon: nil,
        color_theme: nil,
        body_text: body_text,
        button_text: nil,
        button_link: nil
      ))
    end

    it "does not render header section" do
      expect(page).to_not have_css(".cms-resource-card__top-content")
    end

    it "does not render an icon" do
      expect(page).to_not have_css("img")
    end

    it "does not have a color scheme" do
      expect(page).to_not have_css("[class^='cms-color-theme']")
    end

    it "does not render a button" do
      expect(page).to_not have_css("a")
    end
  end
end
