require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Queries::Components::Blocks::FullWidthImageBanner do
  it_should_behave_like "a strapi graphql component",
    %w[
      backgroundImage
      overlayTitle
      overlayText
      overlayIcon
      overlaySide
    ]
end
