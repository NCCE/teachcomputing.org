# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cms::EnrichmentComponent, type: :component do
  before do
    render_inline(Cms::EnrichmentComponent.new(
      title: Cms::Models::RichHeader.new(blocks: Cms::Mocks::RichBlocks.generate_data),
      details: Cms::Mocks::RichBlocks.generate_data,
      link: "https:://www.teachcomputing.org/test-enrichment",
      i_belong: false,
      type: Cms::Models::EnrichmentType.new(
        name: "Challenge",
        icon: Cms::Mocks::Image.as_model
      ),
      terms: ["Spring", "Autumn"],
      age_groups: ["KS1", "KS3"],
      partner_icon: nil
    ))
  end

  it "renders the link to enrichment" do
    expect(page).to have_link(href: "https:://www.teachcomputing.org/test-enrichment")
  end

  it "render the terms in a comma seperated alphabetical ordered list" do
    expect(page).to have_css(".enrichment__term-details", text: "Autumn, Spring")
  end

  it "render the terms in a comma seperated list of age groups" do
    expect(page).to have_css(".enrichment__term-details", text: "KS1, KS3")
  end
end
