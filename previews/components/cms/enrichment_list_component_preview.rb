# frozen_string_literal: true

class Cms::EnrichmentListComponentPreview < ViewComponent::Preview
  def default
    render(Cms::EnrichmentListComponent.new(enrichments: "enrichments"))
  end
end
