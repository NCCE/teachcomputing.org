require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Queries::Components::Blocks::HorizontalCardWithAsides do
  it_should_behave_like "a strapi graphql component",
    %w[
      textContent
      asides
      bkColor
      button
      theme
    ]
end
