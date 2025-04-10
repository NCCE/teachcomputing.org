# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cms::AccordionSectionComponent, type: :component do
  let(:title) { Faker::Lorem.word }

  before do
    render_inline(described_class.new(
      id: 1,
      title:,
      background_color: "light-grey",
      accordion_blocks: Array.new(2) {
        Cms::Mocks::DynamicComponents::ContentBlocks::AccordionBlock.as_model(
          text_content: Cms::Mocks::RichBlocks.as_model
        )
      }
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

  it "assigns the id to the component" do
    expect(page).to have_css("#accordion-section-1")
  end
end
