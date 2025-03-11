require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Queries::Components::ContentBlocks::Testimonial do
  it_should_behave_like "a strapi graphql component",
    %w[
      quote
      avatar
      name
      jobTitle
    ]
end
