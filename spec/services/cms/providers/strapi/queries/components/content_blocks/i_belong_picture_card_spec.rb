require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Queries::Components::ContentBlocks::IBelongPictureCard do
  it_should_behave_like "a strapi graphql component",
    %w[
      title
      textContent
      image
      loggedOutLinkTitle
      loggedOutLink
      enrolledLinkTitle
      enrolledLink
      notEnrolledLinkTitle
      notEnrolledLink
    ]
end
