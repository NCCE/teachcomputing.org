# frozen_string_literal: true

class CmsQuestionAndAnswerComponent < CmsWithAsidesComponent
  def initialize(question:, answer:, aside_sections:)
    super(aside_sections:)
    @question = question
    @answer = answer
  end
end
