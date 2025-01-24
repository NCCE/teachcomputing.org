module Cms
  module Collections
    class Programme < Resource
      def to_search_record(index_time)
        raise NotImplementedError
      end

      def self.is_collection = true

      def self.collection_attribute_mappings
        []
      end

      def self.resource_attribute_mappings
        [
          {model: Models::Slug, key: nil, param_name: :slug},
          {model: Models::TextField, key: :statusPendingTitle},
          {model: Models::TextBlock, key: :statusPendingText, with_wrapper: false},
          {model: Models::TextField, key: :statusCompletedTitle},
          {model: Models::TextBlock, key: :statusCompletedText, with_wrapper: false}
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
