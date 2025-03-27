require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Queries::Components::ContentBlocks::AccordionBlock do
  it_should_behave_like "a strapi graphql component",
    %w[
      heading
      summaryText
      content
    ]
end
