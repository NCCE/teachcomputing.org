module Cms
  module Collections
    class EmailTemplate < Resource
      def self.is_collection = true

      def self.collection_attribute_mapping = []

      def self.resource_attribute_mappings
        [
          {model: Cms::Models::EmailTemplate, key: nil}
        ]
      end

      def template
        data_models[0]
      end

      def self.cache_expiry
        15.minutes
      end

      def self.resource_key
        "email-templates"
      end
    end
  end
end
