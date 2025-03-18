require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Queries::Components::Blocks::TextWithTestimonial do
  it_should_behave_like "a strapi graphql component",
    %w[
      textContent
      bkColor
      testimonial
      testimonialSide
      buttons
    ]
end
