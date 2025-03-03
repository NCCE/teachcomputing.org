require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Queries::Components::Blocks::NumericCardsSection do
  it_should_behave_like "a strapi graphql component",
    %w[
      sectionTitle
      numericCards
      cardsPerRow
      bkColor
    ]
end
