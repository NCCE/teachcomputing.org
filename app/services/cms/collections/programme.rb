module Cms
  module Collections
    class Programme < Resource
      def self.is_collection = true

      def self.collection_attribute_mappings
        []
      end

      def self.resource_attribute_mappings
        [
          {model: Models::Data::Slug, key: nil, param_name: :slug},
          {model: Models::Data::TextField, key: :statusPendingTitle},
          {model: Models::Text::TextBlockWithoutWrapper, key: :statusPendingText},
          {model: Models::Data::TextField, key: :statusCompletedTitle},
          {model: Models::Text::TextBlockWithoutWrapper, key: :statusCompletedText}
        ]
      end

      def self.cache_expiry
        15.minutes
      end

      def self.resource_key = "programmes"

      def self.graphql_key = "programmes"
    end
  end
end
