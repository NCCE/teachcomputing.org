require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Queries::FooterLinkBlock do
  it_should_behave_like "a strapi graphql embed", {key: "footer",
    required_fields: %w[
      link
    ]}
end
