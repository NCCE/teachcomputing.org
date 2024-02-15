module Cms
  module Collections
    class Blog < CollectionResource
      def self.collection_attribute_mappings
        {
          component: BlogPreview,
          fields: [
            {attribute: :title},
            {attribute: :excerpt},
            {attribute: :featuredImage}
          ]
        }
      end

      def self.resource_attribute_mappings
        [
          {
            attribute: :title,
            component: HeroComponent,
            value_param: :title
          },
          {
            attribute: :featuredImage,
            component: nil
          },
          {
            attribute: :content,
            component: CmsRichTextBlockComponent,
            value_param: :blocks
          }
        ]
      end

      def self.resource_key
        "blogs"
      end
    end
  end
end
