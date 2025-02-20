require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Queries::FeaturedImage do
  it_should_behave_like "a strapi graphql query", "featuredImage",
    %w[
      name
      alternativeText
      url
      size
      formats
    ]
end
