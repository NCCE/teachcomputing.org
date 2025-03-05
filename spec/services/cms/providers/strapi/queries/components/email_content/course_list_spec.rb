require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Queries::Components::EmailContent::CourseList do
  it_should_behave_like "a strapi graphql component",
    %w[
      sectionTitle
      courses
      removeOnMatch
    ]
end
