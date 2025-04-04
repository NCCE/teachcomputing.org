# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cms::NumberedIconListComponent, type: :component do
  before do
    render_inline(described_class.new(
      title: Faker::Lorem.sentence,
      title_icon: nil,
      points: [
        Cms::Mocks::Text::RichBlocks.as_model,
        Cms::Mocks::Text::RichBlocks.as_model,
        Cms::Mocks::Text::RichBlocks.as_model
      ],
      aside_sections: []
    ))
  end

  it "should render title if given" do
    expect(page).to have_css(".govuk-heading-m")
  end

  it "should render numbered list" do
    expect(page).to have_css("ol")
  end

  it "should render the correct number of points" do
    expect(page).to have_css("li", count: 3)
  end
end
