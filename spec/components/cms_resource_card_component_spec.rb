# frozen_string_literal: true

require "rails_helper"

RSpec.describe CmsResourceCardComponent, type: :component do
  let(:body_text) { Cms::Mocks::RichBlocks.generate }

  context "has all the values defined" do
    before do
      render_inline(described_class.new(
        title: "Card Title",
        icon: Cms::Mocks::Image.as_model,
        colour_theme: "standard",
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

    it "renders a colour theme" do
      expect(page).to have_css(".cms-colour-theme__border--standard-top")
    end

    it "renders the body text" do
      expect(page).to have_text(body_text.dig(0, :children, 0, :text))
    end

    it "renders a button with a link" do
      expect(page).to have_link("Click here", href: "https://www.example.com")
    end
  end

  context "has only the required values" do
    before do
      render_inline(described_class.new(
        title: "Card title",
        icon: nil,
        colour_theme: nil,
        body_text: body_text,
        button_text: nil,
        button_link: nil
      ))
    end

    it "does not render an icon" do
      expect(page).to_not have_css("img")
    end

    it "does not have a colour scheme" do
      expect(page).to_not have_css("[class^='cms-colour-theme']")
    end

    it "does not render a button" do
      expect(page).to_not have_css("a")
    end
  end
end
