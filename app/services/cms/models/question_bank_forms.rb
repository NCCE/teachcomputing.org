module Cms
  module Models
    class QuestionBankForms
      attr_accessor :forms

      def initialize(forms:)
        @forms = forms
      end

      def render
        nil
      end
    end
  end
end
