require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Queries::Components::Blocks::CourseCardsSection do
  it_should_behave_like "a strapi graphql component",
    %w[
      sectionTitle
      introText
      cards
    ]
end
