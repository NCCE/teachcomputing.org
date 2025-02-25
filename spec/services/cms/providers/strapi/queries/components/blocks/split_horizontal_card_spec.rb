require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Queries::Components::Blocks::SplitHorizontalCard do
  it_should_behave_like "a strapi graphql component",
    %w[
      cardContent
      asideContent
      asideTitle
      asideIcon
      sectionTitle
      bkColor
      colorTheme
    ]
end
