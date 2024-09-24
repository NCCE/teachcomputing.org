# frozen_string_literal: true

class CmsQuestionAndAnswerComponent < CmsWithAsidesComponent
  def initialize(question:, answer:, aside_sections:, answer_icon_block:)
    super(aside_sections:)
    @question = question
    @answer = answer
    @answer_icon_block = answer_icon_block
  end
end
