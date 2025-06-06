# frozen_string_literal: true

class Cms::QuestionAndAnswerComponentPreview < ViewComponent::Preview
  def default
    render(Cms::QuestionAndAnswerComponent.new(
      question: "What is the meaning of life?",
      answer: Cms::Mocks::Text::RichBlocks.as_model,
      aside_sections: [],
      answer_icon_block: Cms::Mocks::DynamicComponents::ContentBlocks::IconBlocks.as_model,
      aside_alignment: "top",
      show_background_triangle: true
    ))
  end
end
