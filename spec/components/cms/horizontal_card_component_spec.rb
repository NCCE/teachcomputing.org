# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cms::HorizontalCardComponent, type: :component do
  context "with only a title and body block" do
    let(:content_block) { Cms::Mocks::RichBlocks.as_model }

    before do
      render_inline(described_class.new(
        external_title: "External title",
        title: "Page title",
        body_blocks: content_block,
        image: nil,
        image_link: nil,
        color_theme: nil,
        icon_block: nil
      ))
    end

    it "renders the external title" do
      expect(page).to have_text("External title")
    end

    it "renders the title" do
      expect(page).to have_text("Page title")
    end

    it "renders the body block text" do
      expect(page).to have_text(content_block.blocks.dig(0, :children, 0, :text))
    end

    it "has no image" do
      expect(page).to_not have_css(".horizontal-card-component__image")
    end

    it "has no color theme" do
      expect(page).to_not have_css("[class^='cms-color-theme__border-']")
    end

    it "has no icon block" do
      expect(page).to_not have_css("horizontal-card-component__icon-wrapper")
    end
  end

  context "with an image" do
    before do
      render_inline(described_class.new(
        title: "Page title",
        body_blocks: Cms::Mocks::RichBlocks.as_model,
        image: Cms::Mocks::Image.as_model,
        image_link: nil,
        color_theme: nil,
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
        body_blocks: Cms::Mocks::RichBlocks.as_model,
        image: Cms::Mocks::Image.as_model,
        image_link: "https://www.example.com",
        color_theme: nil,
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
        body_blocks: Cms::Mocks::RichBlocks.as_model,
        image: Cms::Mocks::Image.as_model,
        image_link: nil,
        color_theme: nil,
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

  context "with a color theme" do
    before do
      render_inline(described_class.new(
        title: "Page title",
        body_blocks: Cms::Mocks::RichBlocks.as_model,
        image: nil,
        image_link: nil,
        color_theme: "standard",
        icon_block: nil
      ))
    end
    it "has a border left in standard colors" do
      expect(page).to have_css(".cms-color-theme__border--standard-left")
    end

    it "adds the theme to the wrapper as a class" do
      expect(page).to have_css(".horizontal-card-component__wrapper.standard-theme")
    end
  end

  context "has an icon block" do
    let(:icon_block) { Cms::Mocks::IconBlocks.as_model }
    before do
      render_inline(described_class.new(
        title: "Page title",
        body_blocks: Cms::Mocks::RichBlocks.as_model,
        image: nil,
        image_link: nil,
        color_theme: nil,
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

  context "with spacing" do
    # Cannot test the spacing rendered on the page, as the ! in the class name breaks Nokogiri
    # Instead we will make sure that the padding method returns the correct values

    context "first" do
      before do
        @instance = described_class.new(
          title: "Page title",
          body_blocks: Cms::Mocks::RichBlocks.as_model,
          spacing: "first"
        )
      end

      it "has the correct padding classes" do
        expect(@instance.padding).to eq({bottom: 3, top: 7})
      end
    end

    context "last" do
      before do
        @instance = described_class.new(
          title: "Page title",
          body_blocks: Cms::Mocks::RichBlocks.as_model,
          spacing: "last"
        )
      end

      it "has the correct padding classes" do
        expect(@instance.padding).to eq({bottom: 7, top: 3})
      end
    end
  end
end
