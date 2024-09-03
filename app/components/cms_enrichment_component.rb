# frozen_string_literal: true

class CmsEnrichmentComponent < ViewComponent::Base
  delegate :cms_image, to: :helpers

  def initialize(title:, details:, link:, i_belong:, terms:, type:, age_groups:, partner_icon: nil, featured: false)
    @title = title
    @details = details
    @link = link
    @i_belong = i_belong
    @terms = terms
    @type = type
    @age_groups = age_groups
    @partner_icon = partner_icon
  end

  def wrapper_classes
    classes = ["enrichment", "show"]
    classes << "i-belong" if @i_belong
    classes
  end

  def data
    data = {
      enrichment_terms: @terms,
      enrichment_age_groups: @age_groups,
      enrichment_type: @type.name
    }
    data[:cms_enrichment_list_component_target] = "enrichment" unless @featured
    data
  end
end
