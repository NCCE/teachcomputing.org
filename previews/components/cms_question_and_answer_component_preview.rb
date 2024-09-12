# frozen_string_literal: true

class CmsQuestionAndAnswerComponentPreview < ViewComponent::Preview
  def default
    render(CmsQuestionAndAnswerComponent.new(
      question: "Who is the best?",
      answer: [{
        type: "paragraph",
        children: [
          {
            text: "Teach computing is the best",
            type: "text"
          }
        ]
      }]
    ))
  end
end
