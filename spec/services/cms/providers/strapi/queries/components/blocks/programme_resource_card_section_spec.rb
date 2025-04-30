require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Queries::Components::Blocks::ProgrammeResourceCardSection do
  it_should_behave_like "a strapi graphql component",
    %w[
      sectionTitle
      introText
      resourceCards
      prog
      bkColor
    ]
end
