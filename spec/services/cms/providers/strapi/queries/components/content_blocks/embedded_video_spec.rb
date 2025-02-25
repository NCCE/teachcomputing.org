require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Queries::Components::ContentBlocks::EmbeddedVideo do
  it_should_behave_like "a strapi graphql component",
    %w[
      url
    ]
end
