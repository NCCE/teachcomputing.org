require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Queries::Components::Buttons::NcceButton do
  it_should_behave_like "a strapi graphql component",
    %w[
      title
      link
      buttonTheme
      loggedInTitle
      loggedInLink
    ]
end
