require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Queries::Components::ContentBlocks::VideoCard do
  it_should_behave_like "a strapi graphql component",
    %w[
      videoUrl
      title
      name
      jobTitle
      textContent
      colorTheme
    ]
end
