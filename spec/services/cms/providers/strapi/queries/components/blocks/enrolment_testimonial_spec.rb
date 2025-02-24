RSpec.describe Cms::Providers::Strapi::Queries::Components::Blocks::EnrolmentTestimonial do
  it_should_behave_like "a strapi graphql component",
    %w[
      title
      testimonial
      enrolledAside
      enrolAside
      bkColor
      programme
    ]
end
