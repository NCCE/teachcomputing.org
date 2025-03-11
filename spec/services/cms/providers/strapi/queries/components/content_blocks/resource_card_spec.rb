require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Queries::Components::ContentBlocks::ResourceCard do
  it_should_behave_like "a strapi graphql component",
    %w[
      title
      icon
      colorTheme
      textContent
      buttonText
      buttonLink
    ]
end
