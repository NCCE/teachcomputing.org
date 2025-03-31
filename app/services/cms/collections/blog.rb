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
          {model: Models::BlogComponents::BlogPreview, key: nil}
        ]
      end

      def self.resource_attribute_mappings
        [
          {model: Models::BlogComponents::SimpleTitle, key: :title},
          {model: Models::ImageComponents::FeaturedImage, key: :featuredImage},
          {model: Models::TextComponents::TextBlock, key: :content},
          {model: Models::MetaComponents::Seo, key: :seo}
        ]
      end

      def self.cache_expiry
        15.minutes
      end

      def self.resource_key = "blogs"

      def self.graphql_key = "blogs"

      def self.sort = "publishDate:desc"

      def self.query_keys
        [:tag]
      end
    end
  end
end
