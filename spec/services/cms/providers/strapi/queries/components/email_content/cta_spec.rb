require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Queries::Components::EmailContent::Cta do
  it_should_behave_like "a strapi graphql component",
    %w[
      text
      link
    ]
end
