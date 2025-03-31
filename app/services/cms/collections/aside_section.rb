module Cms
  module Collections
    class AsideSection < Resource
      def render
        data_models.first.render
      end

      def self.is_collection = true

      def self.collection_attribute_mappings
        []
      end

      def self.resource_attribute_mappings
        [
          {model: Models::AsideComponents::Aside, key: nil}
        ]
      end

      def self.cache_expiry
        4.hours
      end

      def self.resource_key = "aside-sections"

      def self.graphql_key = "asideSections"
    end
  end
end
