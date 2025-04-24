require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Queries::Components::Buttons::EnrolButton do
  it_should_behave_like "a strapi graphql component",
    %w[
      programme
      loggedInButtonText
      loggedOutButtonText
    ]
end
