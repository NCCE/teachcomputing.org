module Cms
  module Collections
    class Enrichment < Resource
      def to_search_record(index_time)
      end

      def self.is_collection = true

      def self.collection_attribute_mappings
        []
      end

      def self.resource_attribute_mappings
        []
      end

      def self.cache_expiry
        4.hours
      end

      def self.resource_key
        "enrichments"
      end

      def self.query_keys
        [:page]
      end
    end
  end
end
