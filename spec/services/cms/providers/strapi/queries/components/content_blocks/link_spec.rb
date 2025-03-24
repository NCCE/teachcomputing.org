require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Queries::Components::ContentBlocks::Link do
  it_should_behave_like "a strapi graphql component",
    %w[
      url
      linkText
    ]
end
