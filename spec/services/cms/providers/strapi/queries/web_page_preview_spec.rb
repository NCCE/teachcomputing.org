require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Queries::WebPagePreview do
  it_should_behave_like "a strapi graphql embed", {required_fields: %w[slug seo]}
end
