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
          {model: Cms::Models::Aside, key: nil}
        ]
      end

      def self.cache_expiry
        4.hours
      end

      def self.resource_key
        "aside-sections"
      end
    end
  end
end
