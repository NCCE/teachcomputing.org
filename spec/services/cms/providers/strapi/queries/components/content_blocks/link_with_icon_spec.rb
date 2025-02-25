RSpec.describe Cms::Providers::Strapi::Queries::Components::ContentBlocks::LinkWithIcon do
  it_should_behave_like "a strapi graphql component",
    %w[
      icon
      url
      linkText
    ]
end
