require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Queries::EnrichmentList do
  it_should_behave_like "a strapi graphql query", "enrichment",
    %w[
      publishedAt
      i_belong
      link
      featured
      terms
      type
      age_groups
      rich_title
      rich_details
      partner_icon
    ]
end
