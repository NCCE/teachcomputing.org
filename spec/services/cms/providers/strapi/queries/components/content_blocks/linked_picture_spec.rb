RSpec.describe Cms::Providers::Strapi::Queries::Components::ContentBlocks::LinkedPicture do
  it_should_behave_like "a strapi graphql component",
    %w[
      image
      link
    ]
end
