RSpec.describe Cms::Providers::Strapi::Queries::Components::ContentBlocks::EnrolButton do
  it_should_behave_like "a strapi graphql component",
    %w[
      programme
      buttonText
    ]
end
