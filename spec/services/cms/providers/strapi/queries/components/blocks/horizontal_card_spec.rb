RSpec.describe Cms::Providers::Strapi::Queries::Components::Blocks::HorizontalCard do
  it_should_behave_like "a strapi graphql component",
    %w[
      title
      textContent
      image
      imageLink
      colorTheme
      iconBlock
      spacing
      externalTitle
    ]
end
