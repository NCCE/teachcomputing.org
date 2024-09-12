module Cms
  module DynamicComponents
    class QuestionAndAnswer
      attr_accessor :question, :answer

      def initialize(question:, answer:)
        @question = question
        @answer = answer
      end

      def render
        CmsQuestionAndAnswerComponent.new(question:, answer:)
      end
    end
  end
end
