# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cms::HorizontalCardWithAsidesComponent, type: :component do
  context "with aside" do
    before do
      stub_strapi_aside_section("test-aside")

      render_inline(described_class.new(
        text: Cms::Mocks::RichBlocks.as_model,
        aside_sections: [{slug: "test-aside"}]
      ))
    end

    it "renders the aside" do
      expect(page).to have_css(".aside-component")
    end

    it "renders the rich text" do
      expect(page).to have_css(".cms-rich-text-block-component")
    end
  end

  context "with multiple asides" do
    before do
      stub_strapi_aside_section("test-aside")
      stub_strapi_aside_section("test-aside2")

      render_inline(described_class.new(
        text: Cms::Mocks::RichBlocks.as_model,
        aside_sections: [{slug: "test-aside"}, {slug: "test-aside2"}]
      ))
    end

    it "renders multiple asides" do
      expect(page).to have_css(".aside-component", count: 2)
    end

    context "with background color" do
      before do
        stub_strapi_aside_section("test-aside")

        render_inline(described_class.new(
          text: Cms::Mocks::RichBlocks.as_model,
          aside_sections: [{slug: "test-aside"}],
          background_color: "orange"
        ))
      end

      it "renders the background color class" do
        expect(page).to have_css(".orange-bg")
      end
    end

    context "with color theme" do
      before do
        stub_strapi_aside_section("test-aside")

        render_inline(described_class.new(
          text: Cms::Mocks::RichBlocks.as_model,
          aside_sections: [{slug: "test-aside"}],
          color_theme: "standard"
        ))
      end

      it "renders the cms theme class" do
        expect(page).to have_css(".cms-color-theme__border--standard-left")
      end
    end

    context "with button" do
      before do
        stub_strapi_aside_section("test-aside")

        render_inline(described_class.new(
          text: Cms::Mocks::RichBlocks.as_model,
          aside_sections: [{slug: "test-aside"}],
          button: Cms::Mocks::NcceButton.as_model
        ))
      end

      it "renders the button" do
        expect(page).to have_css(".govuk-button")
      end
    end
  end
end
