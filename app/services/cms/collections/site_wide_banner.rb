module Cms
  module Collections
    class SiteWideBanner < Resource
      def self.is_collection = true

      def self.resource_attribute_mappings
        [
          {model: Models::Text::TextBlockWithoutWrapper, key: :textContent},
          {model: Models::Data::TextField, key: :startTime},
          {model: Models::Data::TextField, key: :endTime}
        ]
      end

      def self.collection_attribute_mappings
        [
          {model: Models::Text::TextBlockWithoutWrapper, key: :textContent},
          {model: Models::Data::TextField, key: :startTime},
          {model: Models::Data::TextField, key: :endTime}
        ]
      end

      def self.cache_expiry
        5.minutes
      end

      def self.graphql_key = "siteWideBanners"

      def self.resource_key = "site-wide-banners"
    end
  end
end
