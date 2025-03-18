# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cms::CardWrapperComponent, type: :component do
  def resource_cards(number_of_cards)
    Cms::Mocks::ResourceCardSection.as_model(resource_cards: Array.new(number_of_cards) {
      Cms::Mocks::ResourceCard.generate_data
    })
  end

  context "with one card and no title and no sub text" do
    before do
      render_inline(described_class.new(
        title: nil,
        intro_text: nil,
        cards_per_row: 3,
        cards_block: resource_cards(1).cards_block
      ))
    end

    it "renders one card" do
      expect(page).to have_css(".cms-resource-card", count: 1)
    end

    it "does not render a title" do
      expect(page).to_not have_css(".cms-card-wrapper__title", count: 1)
    end

    it "does not render the sub text" do
      expect(page).to have_css(".cms-rich-text-block-component", count: 1)
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

  context "with a title and sub text and background color" do
    before do
      render_inline(described_class.new(
        title: "Section Title",
        intro_text: Cms::Mocks::RichBlocks.as_model,
        cards_per_row: 3,
        cards_block: resource_cards(1).cards_block,
        background_color: "light-grey"
      ))
    end

    it "has a title" do
      expect(page).to have_css(".cms-card-wrapper__title", text: "Section Title")
    end

    it "has the sub text" do
      expect(page).to have_css(".cms-rich-text-block-component", count: 2)
    end

    it "has a background color" do
      expect(page).to have_css(".light-grey-bg")
    end
  end

  context "with title as a paragraph" do
    before do
      render_inline(described_class.new(
        title: "Section Title",
        cards_per_row: 3,
        cards_block: resource_cards(1).cards_block,
        title_as_paragraph: true
      ))
    end

    it "has a title as paragraph" do
      expect(page).to have_css(".govuk-body-m", text: "Section Title")
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
