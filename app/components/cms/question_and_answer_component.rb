# frozen_string_literal: true

class Cms::QuestionAndAnswerComponent < Cms::WithAsidesComponent
  def initialize(question:, answer:, aside_sections:, answer_icon_block:, aside_alignment:, show_background_triangle:)
    super(aside_sections:)
    @question = question
    @answer = answer
    @answer_icon_block = answer_icon_block
    @aside_alignment = aside_alignment
    @show_background_triangle = show_background_triangle
  end

  def aside_alignment_class
    "aside-alignment-#{@aside_alignment}"
  end

  def answer_content_class
    classes = ["question-answer__answer-content"]
    classes << "answer-with-background" if @show_background_triangle
    classes.join(" ")
  end
end
