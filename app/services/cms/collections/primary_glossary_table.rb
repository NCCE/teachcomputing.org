module Cms
  module Collections
    class PrimaryGlossaryTable < Resource
      def self.is_collection = true

      def self.resource_key
        "primary-computing-glossary-table"
      end

      def self.graphql_key
        "primaryComputingGlossaryTables"
      end

      def self.collection_attribute_mappings
        [
          {model: Cms::Models::TextField, key: :term},
          {model: Cms::Models::TextField, key: :keyStage},
          {model: Cms::Models::TextBlock, key: :definition}
        ]
      end

      def self.resource_attribute_mappings
        [
          {model: Cms::Models::TextField, key: :term},
          {model: Cms::Models::TextField, key: :keyStage},
          {model: Cms::Models::TextBlock, key: :definition}
        ]
      end
    end
  end
end
