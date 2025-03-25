module Cms
  module Collections
    class SecondaryQuestionBankItems < Resource
      def self.is_collection = true

      def self.resource_key
        "secondary-question-bank-topic"
      end

      def self.graphql_key
        "secondaryQuestionBankTopics"
      end

      def self.collection_attribute_mappings
        [
          {model: Cms::Models::TextField, key: :topic},
          {model: DynamicComponents::ContentBlocks::QuestionBankForm, key: :forms, is_array: true}
        ]
      end

      def self.resource_attribute_mappings
        [
          {model: Cms::Models::TextField, key: :topic},
          {model: DynamicComponents::ContentBlocks::QuestionBankForm, key: :forms, is_array: true}
        ]
      end

      def self.sort = "order:asc"
    end
  end
end
