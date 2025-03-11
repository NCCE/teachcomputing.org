require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Queries::Components::Blocks::FullWidthText do
  it_should_behave_like "a strapi graphql component",
    %w[
      textContent
      showBottomBorder
      backgroundColor
    ]
end
