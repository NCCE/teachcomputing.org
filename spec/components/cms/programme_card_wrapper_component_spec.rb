# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cms::ProgrammeCardWrapperComponent, type: :component do
  let!(:programme) { create(:i_belong) }

  def programme_cards(number_of_cards)
    Cms::Mocks::ProgrammePictureCardSection.as_model(programme_cards: Array.new(number_of_cards) {
      Cms::Mocks::DynamicComponents::ContentBlocks::ProgrammePictureCard.generate_data
    })
  end

  context "with one card and no title and no sub text" do
    before do
      render_inline(described_class.new(
        title: nil,
        intro_text: nil,
        cards_per_row: 3,
        cards_block: programme_cards(1).cards_block,
        programme:
      ))
    end

    it "renders one card" do
      expect(page).to have_css(".cms-programme-picture-card", count: 1)
    end

    it "does not render a title" do
      expect(page).to_not have_css(".cms-card-wrapper__title", count: 1)
    end

    it "does not render the intro text" do
      expect(page).to have_css(".cms-rich-text-block-component", count: 1)
    end
  end

  context "with a title and sub text and background color" do
    before do
      render_inline(described_class.new(
        title: "Section Title",
        intro_text: Cms::Mocks::RichBlocks.as_model,
        cards_per_row: 3,
        cards_block: programme_cards(1).cards_block,
        background_color: "light-grey",
        programme:
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

  context "with multiple programme cards" do
    before do
      render_inline(described_class.new(
        title: nil,
        cards_per_row: 3,
        cards_block: programme_cards(3).cards_block,
        programme:
      ))
    end

    it "renders three programme cards" do
      expect(page).to have_css(".cms-programme-picture-card", count: 3)
    end
  end

  context "with no programme" do
    before do
      render_inline(described_class.new(
        title: nil,
        cards_per_row: 3,
        cards_block: programme_cards(3).cards_block,
        programme: nil
      ))
    end

    it "does not render" do
      expect(page).to_not have_css(".cms-programme-picture-card")
    end
  end
end
