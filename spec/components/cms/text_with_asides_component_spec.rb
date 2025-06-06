# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cms::TextWithAsidesComponent, type: :component do
  context "with valid aside" do
    before do
      stub_strapi_aside_section("test-aside")
      render_inline(described_class.new(blocks: Cms::Mocks::Text::RichBlocks.as_model, asides: [{slug: "test-aside"}], background_color: nil))
    end

    it "renders govuk grid row" do
      expect(page).to have_css(".tc-gov-grid-wrapper")
    end

    it "has two thirds column" do
      expect(page).to have_css(".govuk-grid-column-two-thirds")
    end

    it "has one third column" do
      expect(page).to have_css(".govuk-grid-column-one-third")
    end

    it "should display aside section" do
      expect(page).to have_css(".aside-component")
    end
  end

  context "with missing aside" do
    before do
      stub_strapi_aside_section_missing("missing-aside")
      render_inline(described_class.new(blocks: Cms::Mocks::Text::RichBlocks.as_model, asides: [{slug: "missing-aside"}], background_color: nil))
    end

    it "renders govuk grid row" do
      expect(page).to have_css(".tc-gov-grid-wrapper")
    end

    it "has two thirds column" do
      expect(page).to have_css(".govuk-grid-column-two-thirds")
    end

    it "has one third column" do
      expect(page).to have_css(".govuk-grid-column-one-third")
    end
  end
end
