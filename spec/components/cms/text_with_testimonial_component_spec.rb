# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cms::TextWithTestimonialComponent, type: :component do
  context "right side testimonial no buttons" do
    before do
      render_inline(described_class.new(
        text_content: Cms::Mocks::RichBlocks.as_model,
        testimonial: Cms::Mocks::Testimonial.as_model,
        testimonial_side: "right",
        background_color: "purple",
        buttons: []
      ))
    end

    it "adds correct row class" do
      expect(page).to have_css(".tc-row.testimonial-right")
    end

    it "renders the testimonial" do
      expect(page).to have_css(".cms-testimonial")
    end

    it "renders the text" do
      expect(page).to have_css(".cms-rich-text-block-component")
    end
  end

  context "left side testimonial with buttons" do
    before do
      render_inline(described_class.new(
        text_content: Cms::Mocks::RichBlocks.as_model,
        testimonial: Cms::Mocks::Testimonial.as_model,
        testimonial_side: "left",
        background_color: "purple",
        buttons: Array.new(2) { Cms::Mocks::DynamicComponents::Buttons::NcceButton.as_model }
      ))
    end

    it "adds correct row class" do
      expect(page).to have_css(".tc-row.testimonial-left")
    end

    it "renders the testimonial" do
      expect(page).to have_css(".cms-testimonial")
    end

    it "renders the text" do
      expect(page).to have_css(".cms-rich-text-block-component")
    end

    it "renders 2 buttons" do
      expect(page).to have_css(".govuk-button", count: 2)
    end
  end
end
