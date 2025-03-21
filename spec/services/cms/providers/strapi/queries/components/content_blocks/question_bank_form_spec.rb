require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Queries::Components::ContentBlocks::QuestionBankForm do
  it_should_behave_like "a strapi graphql component",
    %w[
      formName
      links
    ]
end
