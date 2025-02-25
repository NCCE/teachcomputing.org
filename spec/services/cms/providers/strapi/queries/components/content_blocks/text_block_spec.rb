RSpec.describe Cms::Providers::Strapi::Queries::Components::ContentBlocks::TextBlock do
  it_should_behave_like "a strapi graphql component",
    %w[
      textContent
    ]
end
