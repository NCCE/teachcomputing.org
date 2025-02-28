RSpec.describe Cms::Providers::Strapi::Queries::Components::ContentBlocks::HorizontalLinkCard do
  it_should_behave_like "a strapi graphql component",
    %w[
      title
      linkUrl
      cardContent
      theme
    ]
end
