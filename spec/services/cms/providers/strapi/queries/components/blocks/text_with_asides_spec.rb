RSpec.describe Cms::Providers::Strapi::Queries::Components::Blocks::TextWithAsides do
  it_should_behave_like "a strapi graphql component",
    %w[
      textContent
      asideSections
      bkColor
    ]
end
