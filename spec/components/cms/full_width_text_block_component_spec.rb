# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cms::FullWidthTextBlockComponent, type: :component do
  context "without background color" do
    before do
      render_inline(described_class.new(blocks: Cms::Mocks::Text::RichBlocks.as_model, background_color: nil, show_bottom_border: false))
    end

    it "renders govuk grid row" do
      expect(page).to have_css(".tc-gov-grid-wrapper")
    end

    it "has two full width column" do
      expect(page).to have_css(".govuk-grid-column-full")
    end
  end

  context "with background color and border" do
    before do
      render_inline(described_class.new(
        blocks: Cms::Mocks::Text::RichBlocks.as_model,
        background_color: "light-grey",
        show_bottom_border: true
      ))
    end

    it "renders govuk grid row" do
      expect(page).to have_css(".tc-gov-grid-wrapper.light-grey-bg")
    end

    it "renders border bottom class" do
      expect(page).to have_css(".tc-gov-grid-wrapper.has-border")
    end

    it "has two full width column" do
      expect(page).to have_css(".govuk-grid-column-full")
    end
  end
end
