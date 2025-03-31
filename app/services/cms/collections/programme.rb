module Cms
  module Collections
    class Programme < Resource
      def self.is_collection = true

      def self.collection_attribute_mappings
        []
      end

      def self.resource_attribute_mappings
        [
          {model: Models::MetaComponents::Slug, key: nil, param_name: :slug},
          {model: Models::TextComponents::TextField, key: :statusPendingTitle},
          {model: Models::TextComponents::TextBlockWithoutWrapper, key: :statusPendingText},
          {model: Models::TextComponents::TextField, key: :statusCompletedTitle},
          {model: Models::TextComponents::TextBlockWithoutWrapper, key: :statusCompletedText}
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
