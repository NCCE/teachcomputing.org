# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cms::AccordionBlockComponent, type: :component do
  let(:heading) { Faker::Lorem.word }
  let(:text_content)  { Cms::Mocks::RichBlocks.as_model }

  context "without summary text" do
    before do
      render_inline(described_class.new(
        heading:,
        summary_text: nil,
        text_content:,
        index: 1
      ))
    end

    it "renders the heading text" do
      expect(page).to have_text(heading)
    end

    it "renders the text content" do
      expect(page).to have_css(".cms-rich-text-block-component")
    end

    it "does not render the summary text" do
      expect(page).to_not have_css(".govuk-accordion__section-summary")
    end
  end

  context "with summary text" do
    let(:summary_text)  { Faker::Lorem.sentence }

    before do
      render_inline(described_class.new(
        heading:,
        summary_text:,
        text_content:,
        index: 1
      ))
    end

    it "renders the summary text" do
      expect(page).to have_text(summary_text)
    end
  end
end
