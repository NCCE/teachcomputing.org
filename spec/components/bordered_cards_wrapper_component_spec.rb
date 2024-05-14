require "rails_helper"

RSpec.describe BorderedCardsWrapperComponent, type: :component do
  context "it has a title" do
    before do
      render_inline(described_class.new(cards_per_row: 3, title: "Test Card").tap do |component|
        component.with_card {
          "Test"
        }
        component.with_card {
          "Test 2"
        }
      end)
    end

    it "should have created cards grid" do
      expect(page).to have_css(".bordered-cards-wrapper-component-grid")
    end

    it "should have created individual cards" do
      expect(page).to have_css(".bordered-cards-wrapper-component-grid__item", count: 2)
    end

    it "should have a title" do
      expect(page).to have_css("h2")
    end
  end
  context "it doesn't have a title" do
    before do
      render_inline(described_class.new(cards_per_row: 3).tap do |component|
        component.with_card {
          "Test"
        }
        component.with_card {
          "Test 2"
        }
      end)
    end

    it "should have created cards grid" do
      expect(page).to have_css(".bordered-cards-wrapper-component-grid")
    end

    it "should have created individual cards" do
      expect(page).to have_css(".bordered-cards-wrapper-component-grid__item", count: 2)
    end

    it "should not have a title" do
      expect(page).to_not have_css("h2")
    end
  end
end
