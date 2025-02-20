require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Queries::Seo do
  it_should_behave_like "a strapi graphql keyed embed", "seo",
    %w[
      title
      description
      featuredImage
    ]
end
