# frozen_string_literal: true

class CmsEnrichmentComponent < ViewComponent::Base
  def initialize(title:, details:, link:, i_belong:, terms:, type:, age_groups:, partner_icon: nil)
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
    classes = ["enrichment"]
    classes << "i_belong" if @i_belong
    classes.join(" ")
  end
end
