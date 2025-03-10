require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Queries::Aside do
  it_should_behave_like "a strapi graphql embed", {
    required_fields: %w[
      slug
      title
      showHeadingLine
      content
    ]
  }
end
