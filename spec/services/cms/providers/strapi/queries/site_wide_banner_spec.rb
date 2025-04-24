require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Queries::SiteWideBanner do
  it_should_behave_like "a strapi graphql embed", {
    required_fields: %w[
      startTime
      endTime
      textContent
    ]
  }
end
