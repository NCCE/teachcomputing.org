module Cms
  module Collections
    class WebPage < Resource
      def to_search_record(index_time)
        slug = data_models[0]
        seo_data = data_models[1]
        {
          type: SearchablePages::CmsWebPage.name,
          title: seo_data.title,
          excerpt: seo_data.description,
          metadata: {slug: slug.slug},
          published_at: published_at,
          created_at: index_time,
          updated_at: index_time
        }
      end

      def self.is_collection = true

      def self.collection_attribute_mappings
        [
          {model: Cms::Models::Slug, key: nil},
          {model: Cms::Models::Seo, key: :seo}
        ]
      end

      def self.resource_attribute_mappings
        [
          {model: Cms::Models::PageTitle, key: :pageTitle},
          {model: Cms::Models::Seo, key: :seo},
          {model: Cms::Models::DynamicZone, key: :pageContent}
        ]
      end

      def self.resource_key
        "web-pages"
      end
    end
  end
end
