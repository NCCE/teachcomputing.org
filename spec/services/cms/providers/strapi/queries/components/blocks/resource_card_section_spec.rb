require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Queries::Components::Blocks::ResourceCardSection do
  it_should_behave_like "a strapi graphql component",
    %w[
      resourceCards
      sectionTitle
      cardsPerRow
      bkColor
      introText
    ]
end
