# frozen_string_literal: true

require "rails_helper"

RSpec.describe CmsHorizontalCardComponent, type: :component do
  context "with only a title and body block" do
    before do
      render_inline(described_class.new(
        title: "Page title",
        body_blocks: generate_strapi_content_block
      ))
    end

    it "renders the title" do
      expect(page).to have_text("Page title")
    end

    it "renders the body block text" do
      expect(page).to have_text("Hello world!")
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

  context "with a colour theme" do
    before do
      render_inline(described_class.new(
        title: "Page title",
        body_blocks: [
          type: "paragraph",
          children: [
            {type: "text", text: "Hello world!"}
          ]
        ],
        image: nil,
        image_link: nil,
        colour_theme: "standard",
        icon_block: nil
      ))
    end
  end
end
