require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Queries::Components::ContentBlocks::FileLink do
  it_should_behave_like "a strapi graphql component",
    %w[
      file
    ]
end
