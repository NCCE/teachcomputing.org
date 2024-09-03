# frozen_string_literal: true

class CmsEnrichmentListComponent < ViewComponent::Base
  def initialize(enrichments:, featured_title:, all_title:, type_filter_placeholder:, age_group_filter_placeholder:, term_filter_placeholder:)
    @enrichments = enrichments.sort_by { _1.title.plain_string }
    @featured_title = featured_title
    @all_title = all_title
    @type_filter_placeholder = type_filter_placeholder
    @age_group_filter_placeholder = age_group_filter_placeholder
    @term_filter_placeholder = term_filter_placeholder

    @featured = @enrichments.filter(&:featured)
    @age_groups = enrichments.collect(&:age_groups).flatten.uniq
    @terms = enrichments.collect(&:terms).flatten.uniq
    @types = enrichments.collect { _1.type.name }.uniq
  end
end
