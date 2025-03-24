require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Queries::Components::Blocks::FeedbackBanner do
  it_should_behave_like "a strapi graphql component",
    %w[
      title
      button
    ]
end
