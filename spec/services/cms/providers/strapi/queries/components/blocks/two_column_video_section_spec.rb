require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Queries::Components::Blocks::TwoColumnVideoSection do
  it_should_behave_like "a strapi graphql component",
    %w[
      leftColumnContent
      rightColumnContent
      bkColor
      video
      leftColumnButton
    ]
end
