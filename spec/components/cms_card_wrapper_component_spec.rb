# frozen_string_literal: true

require "rails_helper"

RSpec.describe CmsCardWrapperComponent, type: :component do
  let(:resource_card_one) { Cms::Mocks::ResourceCard.generate(1) }
  let(:resource_card_three) { Cms::Mocks::ResourceCard.generate }

  context "with one card and no title" do
    before do
      render_inline(described_class.new(
        title: nil,
        cards_block: resource_card_one,
        cards_per_row: 3,
        background_color: nil
      ))
    end

    it "renders one card" do
      expect(page).to have_css(".cms-card-wrapper__card", count: 1)
    end

    it "does not render a title" do
      expect(page).to have_css(".govuk-heading-m", count: 1)
    end
  end

  context "with three cards" do
    before do
      render_inline(described_class.new(
        title: nil,
        cards_block: resource_card_three,
        cards_per_row: 3,
        background_color: nil
      ))
    end

    it "renders three cards" do
      expect(page).to have_css(".cms-card-wrapper__card", count: 3)
    end
  end

  context "with a title and background color" do
    before do
      render_inline(described_class.new(
        title: "Section Title",
        cards_block: resource_card_three,
        cards_per_row: 3,
        background_color: "light-grey"
      ))
    end

    it "has a title" do
      expect(page).to have_text("Section Title")
    end

    it "has a background colour" do
      expect(page).to have_css(".light-grey-bg")
    end
  end
end
