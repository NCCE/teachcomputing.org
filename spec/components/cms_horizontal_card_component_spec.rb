# frozen_string_literal: true

require "rails_helper"

RSpec.describe CmsHorizontalCardComponent, type: :component do
  context "with only a title and body block" do
    let(:content_block) { Cms::Mocks::RichBlocks.generate }

    before do
      render_inline(described_class.new(
        title: "Page title",
        body_blocks: content_block,
        image: nil,
        image_link: nil,
        colour_theme: nil,
        icon_block: nil
      ))
    end

    it "renders the title" do
      expect(page).to have_text("Page title")
    end

    it "renders the body block text" do
      expect(page).to have_text(content_block.dig(0, :children, 0, :text))
    end

    it "has no image" do
      expect(page).to_not have_css(".horizontal-card-component__image")
    end

    it "has no colour theme" do
      expect(page).to_not have_css("[class^='cms-colour-theme__border-']")
    end

    it "has no icon block" do
      expect(page).to_not have_css("horizontal-card-component__icon-wrapper")
    end
  end

  context "with an image" do
    before do
      render_inline(described_class.new(
        title: "Page title",
        body_blocks: Cms::Mocks::RichBlocks.generate,
        image: Cms::Mocks::Image.as_model,
        image_link: nil,
        colour_theme: nil,
        icon_block: nil
      ))
    end

    it "has an image" do
      expect(page).to have_css("img")
    end
  end

  context "with an image and image link" do
    before do
      render_inline(described_class.new(
        title: "Page title",
        body_blocks: Cms::Mocks::RichBlocks.generate,
        image: Cms::Mocks::Image.as_model,
        image_link: "https://www.example.com",
        colour_theme: nil,
        icon_block: nil
      ))
    end

    it "has an image" do
      expect(page).to have_css("img")
    end

    it "has a link on the image" do
      expect(page).to have_link(href: "https://www.example.com")
    end
  end

  context "with an image and no image link" do
    before do
      render_inline(described_class.new(
        title: "Page title",
        body_blocks: Cms::Mocks::RichBlocks.generate,
        image: Cms::Mocks::Image.as_model,
        image_link: nil,
        colour_theme: nil,
        icon_block: nil
      ))
    end

    it "has an image" do
      expect(page).to have_css("img")
    end

    it "does not have a link on the image" do
      expect(page).to_not have_link(href: "https://www.example.com")
    end
  end

  context "with a colour theme" do
    before do
      render_inline(described_class.new(
        title: "Page title",
        body_blocks: Cms::Mocks::RichBlocks.generate,
        image: nil,
        image_link: nil,
        colour_theme: "standard",
        icon_block: nil
      ))
    end
    it "has a border left in standard colours" do
      expect(page).to have_css(".cms-colour-theme__border--standard-left-10")
    end
  end

  context "has an icon block" do
    let(:icon_block) { Cms::Mocks::IconBlocks.as_model }
    before do
      render_inline(described_class.new(
        title: "Page title",
        body_blocks: Cms::Mocks::RichBlocks.generate,
        image: nil,
        image_link: nil,
        colour_theme: nil,
        icon_block: icon_block
      ))
    end

    it "has the icon text" do
      expect(page).to have_text(icon_block.icons.first.text)
    end

    it "has the icon image" do
      expect(page).to have_css("img")
    end
  end
end
