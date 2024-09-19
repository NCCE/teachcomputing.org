# frozen_string_literal: true

class CmsEnrichmentListComponentPreview < ViewComponent::Preview
  def default
    render(CmsEnrichmentListComponent.new(enrichments: "enrichments"))
  end
end
