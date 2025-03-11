require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Queries::Components::ContentBlocks::PictureCard do
  it_should_behave_like "a strapi graphql component",
    %w[
      image
      title
      link
      textContent
      colorTheme
    ]
end
