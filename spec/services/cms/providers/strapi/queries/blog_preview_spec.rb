require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Queries::BlogPreview do
  it_should_behave_like "a strapi graphql embed", {
    required_fields: %w[
      title
      excerpt
      publishDate
      slug
      featuredImage
    ]
  }
end
