require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Queries::EnrichmentDynamicZone do
  it_should_behave_like "a strapi graphql embed", {key: "content"}
end
