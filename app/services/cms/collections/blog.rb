module Cms
  module Collections
    class Blog < Resource
      def self.is_collection = true

      def self.collection_attribute_mappings
        [
          {model: Cms::Models::BlogPreview, key: nil}
        ]
      end

      def self.resource_attribute_mappings
        [
          {model: Cms::Models::SimpleTitle, key: :title},
          {model: Cms::Models::FeaturedImage, key: :featuredImage},
          {model: Cms::Models::ContentBlock, key: :content},
          {model: Cms::Models::Seo, key: :seo}
        ]
      end

      def self.resource_key
        "blogs"
      end
    end
  end
end
