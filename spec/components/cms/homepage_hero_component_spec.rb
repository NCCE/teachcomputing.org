# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cms::HomepageHeroComponent, type: :component do
  before do
    render_inline(described_class.new(
      title: "Helping you teach computing",
      house_content: Cms::Mocks::Text::RichBlocks.as_model,
      buttons: [
        Cms::Mocks::DynamicComponents::Buttons::NcceButton.as_model
      ]
    ))
  end

  it "should render the title" do
    expect(page).to have_css("h1", text: "Helping you teach computing")
  end

  it "should render the content" do
    expect(page).to have_css(".cms-rich-text-block-component")
  end

  it "should render the buttons" do
    expect(page).to have_css(".govuk-button")
  end
end
