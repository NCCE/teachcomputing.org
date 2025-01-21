# frozen_string_literal: true

class Cms::EnrichmentListComponentPreview < ViewComponent::Preview
  def default
    render Cms::EnrichmentListComponent.new(
      enrichments: [],
      featured_title: "Featured enrichments",
      all_title: "Search for enrichment",
      type_filter_placeholder: "Type (all)",
      age_group_filter_placeholder: "Age group (all)",
      term_filter_placeholder: "Term (all)"
    )
  end
end
