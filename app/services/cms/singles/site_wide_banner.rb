module Cms
  module Singles
    class SiteWideBanner < Resource
      def self.resource_attribute_mappings
        [
          {model: Models::Meta::SiteWideBanner, key: :textContent}
        ]
      end

      def self.cache_expiry
        15.minutes
      end

      def self.graphql_key = "siteWideBanner"

      def self.resource_key = "siteWideBanner"
    end
  end
end
