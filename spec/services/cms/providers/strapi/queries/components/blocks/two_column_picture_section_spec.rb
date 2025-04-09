require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Queries::Components::Blocks::TwoColumnPictureSection do
  it_should_behave_like "a strapi graphql component",
    %w[
      textContent
      image
      imageSide
      bkColor
      banner
    ]
end
