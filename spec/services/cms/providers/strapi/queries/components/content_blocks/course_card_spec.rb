require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Queries::Components::ContentBlocks::CourseCard do
  it_should_behave_like "a strapi graphql component",
    %w[
      title
      bannerText
      courseCode
      description
      image
    ]
end
