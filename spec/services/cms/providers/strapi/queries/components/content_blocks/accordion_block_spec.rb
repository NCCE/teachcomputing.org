require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Queries::Components::ContentBlocks::AccordionBlock do
  it_should_behave_like "a strapi graphql component",
    %w[
      id
      heading
      summaryText
      textContent
    ]
end
