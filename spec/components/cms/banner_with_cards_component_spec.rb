# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cms::BannerWithCardsComponent, type: :component do
  let(:banner_with_cards) {
    Cms::Mocks::DynamicComponents::Blocks::BannerWithCards.as_model(
      title: "Learn about computing"
    )
  }

  before do
    render_inline(described_class.new(
      title: banner_with_cards.title,
      text_content: banner_with_cards.text_content,
      cards: banner_with_cards.cards,
      background_color: "purple"
    ))
  end

  it "should add background color" do
    expect(page).to have_css(".tc-gov-grid-wrapper.purple-bg")
  end

  it "should render title" do
    expect(page).to have_css("h2", text: "Learn about computing")
  end

  it "should render 2 cards" do
    expect(page).to have_css(".cms-horizontal-link-card", count: 2)
  end
end
