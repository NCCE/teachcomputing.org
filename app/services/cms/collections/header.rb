module Cms
  module Collections
    class Header < Resource
      def self.resource_attribute_mappings
        [
          {model: Models::HeaderMenu, key: :dropDowns}
        ]
      end

      def self.cache_expiry
        15.minutes
      end

      def self.resource_key = "header"

      def self.graphql_key = "header"
    end
  end
end
