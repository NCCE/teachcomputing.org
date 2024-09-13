module Cms
  module DynamicComponents
    class QuestionAndAnswer
      attr_accessor :question, :answer, :aside_sections

      def initialize(question:, answer:, aside_sections:)
        @question = question
        @answer = answer
        @aside_sections = aside_sections
      end

      def render
        CmsQuestionAndAnswerComponent.new(question:, answer:, aside_sections:)
      end
    end
  end
end
