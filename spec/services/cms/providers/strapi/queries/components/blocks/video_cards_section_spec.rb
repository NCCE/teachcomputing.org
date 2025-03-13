require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Queries::Components::Blocks::VideoCardsSection do
  it_should_behave_like "a strapi graphql component",
    %w[
      title
      introText
      videoCards
      bkColor
      cardsPerRow
    ]
end
