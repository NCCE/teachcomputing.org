module Cms
  module Collections
    class SimplePage < Resource
      def self.is_collection = true

      def self.resource_attribute_mappings
        [
          {model: Cms::Models::SimpleTitle, key: :title},
          {model: Cms::Models::ContentBlock, key: :content},
          {model: Cms::Models::Seo, key: :seo}
        ]
      end

      def self.resource_key
        "simple-pages"
      end
    end
  end
end
