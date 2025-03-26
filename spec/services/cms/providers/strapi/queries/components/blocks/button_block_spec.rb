require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Queries::Components::Blocks::ButtonBlock do
  it_should_behave_like "a strapi graphql component",
    %w[
      buttons
      bkColor
      padding
      alignment
      fullWidth
    ]
end
