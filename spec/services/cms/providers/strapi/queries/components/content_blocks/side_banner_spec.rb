require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Queries::Components::ContentBlocks::SideBanner do
  it_should_behave_like "a strapi graphql component",
    %w[
      textContent
      icon
      bannerColor
    ]
end
