require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Queries::Seo do
  it_should_behave_like "a strapi graphql embed", {key: "seo",
    required_fields: %w[
      title
      description
      featuredImage
    ]}
end
