require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Queries::Components::Blocks::CommunityActivityList do
  it_should_behave_like "a strapi graphql component",
    %w[
      intro
      title
      group
    ]
end
