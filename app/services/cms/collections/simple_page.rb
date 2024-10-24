module Cms
  module Collections
    class SimplePage < Resource
      def to_search_record(index_time)
        page_data = data_models.first
        {
          type: SearchablePages::CmsSimplePage.name,
          title: page_data.title,
          excerpt: page_data.excerpt,
          metadata: {slug: page_data.slug},
          published_at: published_at,
          created_at: index_time,
          updated_at: index_time
        }
      end

      def self.is_collection = true

      def self.collection_attribute_mappings
        [
          {model: Cms::Models::SimplePagePreview, key: nil}
        ]
      end

      def self.resource_attribute_mappings
        [
          {model: Cms::Models::SimpleTitle, key: :title},
          {model: Cms::Models::TextBlock, key: :content},
          {model: Cms::Models::Seo, key: :seo}
        ]
      end

      def self.resource_key
        "simple-pages"
      end
    end
  end
end
