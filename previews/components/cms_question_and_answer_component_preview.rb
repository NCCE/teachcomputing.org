# frozen_string_literal: true

class CmsQuestionAndAnswerComponentPreview < ViewComponent::Preview
  def default
    render(CmsQuestionAndAnswerComponent.new(
      question: "What is the meaning of life?",
      answer: [{
        type: "paragraph",
        children: [
          {
            text: "42",
            type: "text"
          }
        ]
      }],
      aside_sections: [{
        slug: "intro-to-primary-computing"
      }]
    ))
  end
end
