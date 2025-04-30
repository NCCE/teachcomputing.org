require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Queries::Components::Blocks::ProgrammePictureCardSection do
  it_should_behave_like "a strapi graphql component",
    %w[
      sectionTitle
      introText
      programmeCards
      prog
      bkColor
    ]
end
