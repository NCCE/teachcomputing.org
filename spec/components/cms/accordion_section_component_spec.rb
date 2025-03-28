# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cms::AccordionSectionComponent, type: :component do
  let(:title) { Faker::Lorem.word }

  before do
    render_inline(described_class.new(
      title:,
      background_color: "light-grey",
      accordion_block: Array.new(2) {Cms::Mocks::DynamicComponents::ContentBlocks::AccordionBlock.as_model}
    ))
  end

  it "renders the title" do
    expect(page).to have_text(title)
  end

  it "renders the accordion blocks" do
    expect(page).to have_css(".govuk-accordion__section", count: 2)
  end

  it "has the background color class" do
    expect(page).to have_css(".light-grey-bg")
  end
end
