module Cms
  module Collections
    class Blog < CollectionResource
      def self.collection_attribute_mappings
        {
          component: BlogPreviewComponent,
          fields: [
            {attribute: :title},
            {attribute: :excerpt},
            {attribute: :publishDate},
            {attribute: :slug},
            {attribute: :featuredImage, populate: true}
          ]
        }
      end

      def self.resource_attribute_mappings
        [
          {
            attribute: :title,
            component: CmsHeroComponent,
            value_param: :title
          },
          {
            attribute: :featuredImage,
            component: FeaturedImageComponent
          },
          {
            attribute: :content,
            component: CmsRichTextBlockComponent,
            value_param: :blocks
          },
          {
            attribute: :seo,
            component: SeoBlockComponent
          }
        ]
      end

      def self.resource_key
        "blogs"
      end

      def self.sort_keys
        ["publishDate:desc"]
      end
    end
  end
end
