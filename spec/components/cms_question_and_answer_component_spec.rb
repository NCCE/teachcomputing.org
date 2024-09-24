# frozen_string_literal: true

require "rails_helper"

RSpec.describe CmsQuestionAndAnswerComponent, type: :component do
  before do
    stub_strapi_aside_section
    render_inline(described_class.new(
      question: "Do you want to know more?",
      answer: [{
        type: "paragraph",
        children: [
          {
            text: Faker::Lorem.paragraph,
            type: "text"
          }
        ]
      }],
      aside_sections: [{slug: "test-aside"}],
      answer_icon_block: nil
    ))
  end

  it "should render question box" do
    expect(page).to have_css(".question-answer__question-content", text: "Do you want to know more?")
  end

  it "should render answer box with rich text block" do
    expect(page).to have_css(".question-answer__answer-content .cms-rich-text-block-component")
  end
end
