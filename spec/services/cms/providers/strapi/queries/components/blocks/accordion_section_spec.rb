require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Queries::Components::Blocks::AccordionSection do
  it_should_behave_like "a strapi graphql component",
    %w[
      id
      title
      bkColor
      accordionBlock
    ]
end
