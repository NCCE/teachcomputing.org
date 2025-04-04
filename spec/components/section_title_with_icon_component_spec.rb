# frozen_string_literal: true

require "rails_helper"

RSpec.describe SectionTitleWithIconComponent, type: :component do
  context "without text" do
    before do
      render_inline(described_class.new(text: nil))
    end

    it "should not render component" do
      expect(page).not_to have_css(".section-title-with-icon")
    end
  end

  context "without icon" do
    let(:text) { Faker::Lorem.sentence }
    before do
      render_inline(described_class.new(text:))
    end

    it "should render component" do
      expect(page).to have_css(".section-title-with-icon")
    end

    it "should render the text" do
      expect(page).to have_css(".govuk-heading-m", text:)
    end
  end

  context "with small text size" do
    let(:text) { Faker::Lorem.sentence }
    before do
      render_inline(described_class.new(text:, text_size: :small))
    end

    it "should render component" do
      expect(page).to have_css(".section-title-with-icon")
    end

    it "should render the text with correct class" do
      expect(page).to have_css(".govuk-heading-s", text:)
    end
  end

  context "with icon" do
    let(:text) { Faker::Lorem.sentence }
    before do
      render_inline(described_class.new(text:, icon: Cms::Mocks::Images::Image.as_model))
    end

    it "should render component" do
      expect(page).to have_css(".section-title-with-icon")
    end

    it "should render the text" do
      expect(page).to have_css(".govuk-heading-m", text:)
    end

    it "should render image" do
      expect(page).to have_css("img")
    end
  end
end
