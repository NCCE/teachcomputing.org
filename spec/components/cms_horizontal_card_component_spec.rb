# frozen_string_literal: true

require "rails_helper"

RSpec.describe CmsHorizontalCardComponent, type: :component do
  context "with only a title and body block" do
    let(:content_block) { generate_strapi_content_block }

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
        body_blocks: generate_strapi_content_block,
        image: Cms::Providers::Strapi::Factories::ModelFactory.to_image(generate_strapi_image_attributes),
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
        body_blocks: generate_strapi_content_block,
        image: Cms::Providers::Strapi::Factories::ModelFactory.to_image(generate_strapi_image_attributes),
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
        body_blocks: generate_strapi_content_block,
        image: Cms::Providers::Strapi::Factories::ModelFactory.to_image(generate_strapi_image_attributes),
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
        body_blocks: generate_strapi_content_block,
        image: nil,
        image_link: nil,
        colour_theme: "standard",
        icon_block: nil
      ))
    end
    it "has a border left in standard colours" do
      expect(page).to have_css(".cms-colour-theme__border--standard-left")
    end
  end

  context "has an icon block" do
    before do
      render_inline(described_class.new(
        title: "Page title",
        body_blocks: generate_strapi_content_block,
        image: nil,
        image_link: nil,
        colour_theme: nil,
        icon_block: Cms::DynamicComponents::IconBlock.new(icons:
          [
            Cms::DynamicComponents::Icon.new(
              text: "Face to face",
              image: Cms::Providers::Strapi::Factories::ModelFactory.to_image(generate_strapi_image_attributes)
            )
          ])
      ))
    end

    it "has the icon text" do
      expect(page).to have_text("Face to face")
    end

    it "has the icon image" do
      expect(page).to have_css("img[src*='http://strapi.teachcomputing.test/medium_i_belong_camp_0_99e3e4622a.png']")
    end
  end
end
