module Cms
  module Collections
    class SecondaryQuestionBankItems < Resource
      def self.is_collection = true

      def self.resource_key
        "secondary-question-bank-topics"
      end

      def self.graphql_key
        "secondaryQuestionBankTopics"
      end

      def self.collection_attribute_mappings
        [
          {model: Models::Data::TextField, key: :topic},
          {model: Models::DynamicComponents::ContentBlocks::QuestionBankForm, key: :forms, is_array: true}
        ]
      end

      def self.resource_attribute_mappings
        [
          {model: Models::Data::TextField, key: :topic},
          {model: Models::DynamicComponents::ContentBlocks::QuestionBankForm, key: :forms, is_array: true}
        ]
      end

      def self.sort = "order:asc"
    end
  end
end
