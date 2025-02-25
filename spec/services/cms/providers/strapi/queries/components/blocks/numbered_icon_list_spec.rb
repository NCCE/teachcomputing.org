require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Queries::Components::Blocks::NumberedIconList do
  it_should_behave_like "a strapi graphql component",
    %w[
      titleIcon
      title
      points
      asideSections
    ]
end
