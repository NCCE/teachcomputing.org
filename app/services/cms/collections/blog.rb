module Cms
  module Collections
    class Blog < Resource
      def to_search_record(index_time)
        blog_data_model = data_models.first
        {
          type: SearchablePages::CmsBlog.name,
          title: blog_data_model.title,
          excerpt: blog_data_model.excerpt,
          metadata: {slug: blog_data_model.slug},
          published_at: blog_data_model.publish_date,
          created_at: index_time,
          updated_at: index_time
        }
      end

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

      def self.cache_expiry
        15.minutes
      end

      def self.resource_key
        "blogs"
      end

      def self.query_keys
        [:tag]
      end
    end
  end
end
