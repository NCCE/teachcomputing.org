module Cms
  module Collections
    class EnrichmentPage < Resource
      def to_search_record(index_time)
      end

      def self.is_collection = true

      def self.collection_attribute_mappings
        [
          {model: Cms::Models::Seo, key: :seo}
        ]
      end

      def self.resource_attribute_mappings
        [
          {model: Models::Seo, key: :seo},
          {model: Models::PageTitle, key: :pageTitle},
          {model: Models::DynamicZone, key: :content},
          {model: Models::EnrichmentList, key: :enrichments}
        ]
      end

      def self.cache_expiry
        4.hours
      end

      def self.resource_key
        "enrichment-pages"
      end
    end
  end
end
