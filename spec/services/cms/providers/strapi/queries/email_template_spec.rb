require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Queries::EmailTemplate do
  it_should_behave_like "a strapi graphql embed", {
    required_fields: %w[
      name
      slug
      subject
      active
      programme
      completedGroupings
      activityState
      enrolled
      emailContent
    ]
  }
end
