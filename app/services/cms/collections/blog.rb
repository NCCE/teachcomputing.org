module Cms
  module Collections
    class Blog < CollectionResource
      def self.collection_attribute_mappings
        {
          component: BlogPreview,
          fields: [
            {
              attribute: :title
            }
          ]
        }
      end

      def self.resource_attribute_mappings
        {}
      end

      def self.resource_key
        "blogs"
      end
    end
  end
end
