module Cms
  module Collections
    class SiteWideBanner < Resource
      def self.is_collection = true

      def self.resource_attribute_mappings
        [
          {model: Models::Text::RichHeader, key: :textContent, param_name: :text_content},
          {model: Models::Data::TextField, key: :startTime, param_name: :start_time},
          {model: Models::Data::TextField, key: :endTime, param_name: :end_time}
        ]
      end

      def self.collection_attribute_mappings
        [
          {model: Models::Text::RichHeader, key: :textContent, param_name: :text_content},
          {model: Models::Data::TextField, key: :startTime, param_name: :start_time},
          {model: Models::Data::TextField, key: :endTime, param_name: :end_time}
        ]
      end

      def self.cache_expiry
        5.minutes
      end

      def self.graphql_key = "siteWideBanners"

      def self.resource_key = "site-wide-banners"

      def self.sort = "startTime:desc"
    end
  end
end
