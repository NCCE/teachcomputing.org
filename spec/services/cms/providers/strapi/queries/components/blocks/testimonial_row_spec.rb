require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Queries::Components::Blocks::TestimonialRow do
  it_should_behave_like "a strapi graphql component",
    %w[
      title
      testimonials
      backgroundColor
    ]
end
