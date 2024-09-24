module Cms
  module DynamicComponents
    class QuestionAndAnswer
      attr_accessor :question, :answer, :aside_sections, :answer_icon_block

      def initialize(question:, answer:, aside_sections:, answer_icon_block:)
        @question = question
        @answer = answer
        @aside_sections = aside_sections
        @answer_icon_block = answer_icon_block
      end

      def render
        CmsQuestionAndAnswerComponent.new(question:, answer:, aside_sections:, answer_icon_block:)
      end
    end
  end
end
