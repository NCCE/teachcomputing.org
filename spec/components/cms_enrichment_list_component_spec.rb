# frozen_string_literal: true

require "rails_helper"

RSpec.describe CmsEnrichmentListComponent, type: :component do
  before do
    render_inline CmsEnrichmentListComponent.new(
      enrichments: [],
      featured_title: "Featured enrichments",
      all_title: "Search for enrichment",
      type_filter_placeholder: "Type (all)",
      age_group_filter_placeholder: "Age group (all)",
      term_filter_placeholder: "Term (all)"
    )
  end

  it "renders featured heading" do
    expect(page).to have_css(".govuk-heading-m", text: "Featured enrichments")
  end

  it "renders all sections heading" do
    expect(page).to have_css(".govuk-heading-m", text: "Search for enrichment")
  end

  it "renders term select with place holder" do
    expect(page).to have_css("select[data-cms-enrichment-list-component-target='termSelect'] option", text: "Term (all)")
  end

  it "renders ageGroup select with place holder" do
    expect(page).to have_css("select[data-cms-enrichment-list-component-target='ageGroupSelect'] option", text: "Age group (all)")
  end

  it "renders type select with place holder" do
    expect(page).to have_css("select[data-cms-enrichment-list-component-target='typeSelect'] option", text: "Type (all)")
  end
end
