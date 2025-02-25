require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Queries::Components::Blocks::PictureCardSection do
  it_should_behave_like "a strapi graphql component",
    %w[
      sectionTitle
      cardsPerRow
      bkColor
      pictureCards
    ]
end
