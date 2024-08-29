# frozen_string_literal: true

class CmsEnrichmentListComponent < ViewComponent::Base
  def initialize(enrichments:, featured_title:, all_title:)
    @enrichments = enrichments
    @featured_title = featured_title
    @all_title = all_title

    @featured = enrichments.filter(&:featured)
    @age_groups = enrichments.collect(&:age_groups).flatten.uniq
    @terms = enrichments.collect(&:terms).flatten.uniq
    @types = enrichments.collect { _1.type.name }.uniq
  end
end
