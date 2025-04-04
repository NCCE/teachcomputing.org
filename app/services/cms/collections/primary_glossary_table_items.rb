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
          {model: Models::Data::TextField, key: :term},
          {model: Models::Data::TextField, key: :keyStage},
          {model: Models::Text::TextBlock, key: :definition}
        ]
      end

      def self.resource_attribute_mappings
        [
          {model: Models::Data::TextField, key: :term},
          {model: Models::Data::TextField, key: :keyStage},
          {model: Models::Text::TextBlock, key: :definition}
        ]
      end
    end
  end
end
