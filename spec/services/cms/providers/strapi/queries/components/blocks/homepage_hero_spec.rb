require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Queries::Components::Blocks::HomepageHero do
  it_should_behave_like "a strapi graphql component",
    %w[
      title
      houseText
      buttons
    ]
end
