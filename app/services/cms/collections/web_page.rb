module Cms
  module Collections
    class WebPage < Resource
      def to_search_record(index_time)
      end

      def self.is_collection = true

      def self.collection_attribute_mapping = []

      def self.resource_attribute_mappings
        [
          {model: Cms::Models::PageTitle, key: :pageTitle},
          {model: Cms::Models::Seo, key: :seo},
          {model: Cms::Models::DynamicZone, key: :pageContent}
        ]
      end

      def self.resource_key
        "web-pages"
      end
    end
  end
end
