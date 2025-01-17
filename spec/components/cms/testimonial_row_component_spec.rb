# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cms::TestimonialRowComponent, type: :component do
  context "Without title and background" do
    let(:testimonials) { Array.new(2) { Cms::Mocks::Testimonial.as_model } }

    before do
      render_inline(described_class.new(
        title: nil,
        testimonials:,
        background_color: nil
      ))
    end

    it "should not render title" do
      expect(page).not_to have_css(".govuk-heading-m")
    end

    it "should render row" do
      expect(page).to have_css(".cms-testimonial-row")
    end

    it "should render two testimonials" do
      expect(page).to have_css(".cms-testimonial", count: 2)
    end
  end

  context "With title and background" do
    let(:title) { Faker::Lorem.sentence }
    let(:testimonials) { Array.new(3) { Cms::Mocks::Testimonial.as_model } }
    let(:background_color) { "light-grey" }

    before do
      render_inline(described_class.new(
        title:,
        testimonials:,
        background_color:
      ))
    end

    it "should render title" do
      expect(page).to have_css(".govuk-heading-m", text: title)
    end

    it "should have background color" do
      expect(page).to have_css(".cms-testimonial-row.light-grey-bg")
    end

    it "should have 3 testimonials" do
      expect(page).to have_css(".cms-testimonial", count: 3)
    end
  end
end
