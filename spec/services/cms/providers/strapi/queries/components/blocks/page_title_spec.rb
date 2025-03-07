require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Queries::PageTitle do
  it_should_behave_like "a strapi graphql embed", {key: "pageTitle",
    required_fields: %w[
      title
      subText
      titleImage
      titleVideoUrl
      bkColor
      iBelongFlag
    ]}
end
