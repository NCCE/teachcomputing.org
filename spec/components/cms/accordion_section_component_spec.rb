# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cms::AccordionSectionComponent, type: :component do
  let(:title) { Faker::Lorem.word }
  let(:accordion_blocks) {
    Cms::Providers::Strapi::Factories::BlocksFactory.to_accordion_block_array(
      Array.new(2) { Cms::Mocks::DynamicComponents::ContentBlocks::AccordionBlock.generate_raw_data }
    )
  }

  before do
    render_inline(described_class.new(
      id: 1,
      title:,
      background_color: "light-grey",
      accordion_blocks:
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

  it "assigns the cms id" do
    expect(page).to have_css("#accordion-section-1")
  end
end
