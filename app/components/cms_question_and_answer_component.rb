# frozen_string_literal: true

class CmsQuestionAndAnswerComponent < ViewComponent::Base
  def initialize(question:, answer:)
    @question = question
    @answer = answer
    @aside_models = []
  end
end
