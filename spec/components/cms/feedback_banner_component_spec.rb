# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cms::FeedbackBannerComponent, type: :component do
  before do
    render_inline(described_class.new(
      title: "Help us make these resources better",
      button: Cms::Mocks::DynamicComponents::Buttons::NcceButton.as_model
    ))
  end

  it "renders the title" do
    expect(page).to have_text("Help us make these resources better")
  end

  it "renders the ncce button" do
    expect(page).to have_css(".govuk-button")
  end
end
