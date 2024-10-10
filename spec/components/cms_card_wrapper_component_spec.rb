# frozen_string_literal: true

require "rails_helper"

RSpec.describe CmsCardWrapperComponent, type: :component do
  def resource_cards(number_of_cards)
    Cms::Mocks::ResourceCardSection.as_model(resource_card: Array.new(number_of_cards) {
      Cms::Mocks::ResourceCard.generate_data
    })
  end

  context "with one card and no title" do
    before do
      render_inline(described_class.new(
        title: nil,
        cards_per_row: 3,
        cards_block: resource_cards(1).cards_block
      ))
    end

    it "renders one card" do
      expect(page).to have_css(".cms-resource-card", count: 1)
    end

    it "does not render a title" do
      expect(page).to have_css(".govuk-heading-m", count: 1)
    end
  end

  context "with three cards" do
    before do
      render_inline(described_class.new(
        title: nil,
        cards_per_row: 3,
        cards_block: resource_cards(3).cards_block
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
        cards_per_row: 3,
        cards_block: resource_cards(1).cards_block,
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

  context "is a resource card" do
    before do
      render_inline(described_class.new(
        title: nil,
        cards_per_row: 3,
        cards_block: resource_cards(1).cards_block
      ))
    end

    it "renders one resource card" do
      expect(page).to have_css(".cms-resource-card")
    end
  end

  context "is a picture card" do
    let(:picture_card) { Cms::Mocks::PictureCardSection.as_model }
    before do
      render_inline(described_class.new(
        title: nil,
        cards_per_row: 3,
        cards_block: picture_card.cards_block
      ))
    end

    it "renders three picture cards" do
      expect(page).to have_css(".cms-picture-card", count: 3)
    end
  end
end
