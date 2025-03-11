require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Queries::Components::Blocks::QuestionAndAnswer do
  it_should_behave_like "a strapi graphql component",
    %w[
      question
      answer
      asideAlignment
      showBackgroundTriangle
      asideSections
      answerIcons
    ]
end
