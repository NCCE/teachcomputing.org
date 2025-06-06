require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Queries::Components::EmbedBlocks::SectionTitle do
  it_should_behave_like "a strapi graphql component",
    %w[
      title
      icon
    ]
end
