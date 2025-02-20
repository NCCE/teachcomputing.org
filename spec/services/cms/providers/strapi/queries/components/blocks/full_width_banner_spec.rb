RSpec.describe Cms::Providers::Strapi::Queries::Components::Blocks::FullWidthBanner do
  it_should_behave_like "a strapi graphql component",
    %w[
      textContent
      image
      imageSide
      buttons
      imageLink
      backgroundColor
      sectionTitle
      showBottomBorder
    ]
end
