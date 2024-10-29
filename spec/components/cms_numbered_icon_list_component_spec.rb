# frozen_string_literal: true

require "rails_helper"

RSpec.describe CmsNumberedIconListComponent, type: :component do
  before do
    render_inline(described_class.new(
      title: Faker::Lorem.sentence,
      title_icon: nil,
      points: [],
      aside_sections: []
    ))
  end

  it "should render title if given" do
    expect(page).to have_css(".govuk-heading-m")
  end
end
