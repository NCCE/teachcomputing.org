require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Queries::Components::ContentBlocks::ProgrammeResourceCard do
  it_should_behave_like "a strapi graphql component",
    %w[
      title
      loggedOutTextContent
      notEnrolledTextContent
      enrolledTextContent
      loggedOutButtonText
      loggedInButtonText
      clr
    ]
end
