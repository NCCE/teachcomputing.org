# frozen_string_literal: true

require "rails_helper"

RSpec.describe CmsPictureCardComponent, type: :component do
  let(:title) { Faker::Lorem.word }
  let(:body_text) { Cms::Mocks::RichBlocks.as_model }

  context "has all the values defined" do
    before do
      render_inline(described_class.new(
        title: title,
        image: Cms::Mocks::Image.as_model,
        color_theme: "standard",
        body_text: body_text,
        link: Faker::Internet.url
      ))
    end

    it "renders a title" do
      expect(page).to have_text(title)
    end

    it "renders and image" do
      expect(page).to have_css("img")
    end

    it "renders the rich text block" do
      expect(page).to have_css(".cms-rich-text-block-component")
    end

    it "has a link on the image" do
      expect(page).to have_css("a img")
    end

    it "has a linked title" do
      expect(page).to have_css("h2 a")
    end

    it "applies the ribbon class" do
      expect(page).to have_css(".cms-color-theme__border--standard-bottom")
    end
  end

  context "has only the required values" do
    before do
      render_inline(described_class.new(
        title: title,
        image: Cms::Mocks::Image.as_model,
        body_text: body_text
      ))
    end

    it "does not have a link" do
      expect(page).to_not have_css("a")
    end

    it "does not have a ribbon" do
      expect(page).to_not have_css("[class^='cms-color-theme']")
    end
  end
end
