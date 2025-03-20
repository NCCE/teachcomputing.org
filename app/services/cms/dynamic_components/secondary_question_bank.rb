module Cms
  module DynamicComponents
    class SecondaryQuestionBank
      attr_accessor :title

      def initialize(title:)
        @title = title
      end

      def render
        SecondaryQuestionBankComponent.new(title:)
      end
    end
  end
end
