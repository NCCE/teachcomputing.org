module Cms
  module Collections
    class PrimaryGlossaryTableItems < Resource
      def self.is_collection = true

      def self.resource_key
        "primary-computing-glossary-table"
      end

      def self.graphql_key
        "primaryComputingGlossaryTables"
      end

      def self.collection_attribute_mappings
        [
          {model: Models::TextComponents::TextField, key: :term},
          {model: Models::TextComponents::TextField, key: :keyStage},
          {model: Models::TextComponents::TextBlock, key: :definition}
        ]
      end

      def self.resource_attribute_mappings
        [
          {model: Models::TextComponents::TextField, key: :term},
          {model: Models::TextComponents::TextField, key: :keyStage},
          {model: Models::TextComponents::TextBlock, key: :definition}
        ]
      end
    end
  end
end
