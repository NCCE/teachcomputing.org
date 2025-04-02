module Cms
  module DynamicComponents
    class SecondaryQuestionBank
      attr_accessor :title

      def initialize(title:)
        @title = title
      end

      def render
        Cms::SecondaryQuestionBankComponent.new(title:)
      end
    end
  end
end
