require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Queries::Components::Blocks::FeaturedBlogs do
  it_should_behave_like "a strapi graphql component",
    %w[
      title
    ]
end
