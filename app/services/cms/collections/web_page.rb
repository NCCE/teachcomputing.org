module Cms
  module Collections
    class WebPage < Resource
      def to_search_record(index_time)
        page_data = data_models[0]
        {
          type: SearchablePages::CmsWebPage.name,
          title: page_data.title,
          excerpt: page_data.description,
          metadata: {slug: page_data.slug},
          published_at: published_at,
          created_at: index_time,
          updated_at: index_time
        }
      end

      def slug
        data_models[0].slug
      end

      def self.is_collection = true

      def self.collection_attribute_mappings
        [
          {model: Models::Data::WebPagePreview, key: nil}
        ]
      end

      def self.resource_attribute_mappings
        [
          {model: Models::Data::Slug, key: nil},
          {model: Models::Meta::PageTitle, key: :pageTitle},
          {model: Models::Meta::Seo, key: :seo},
          {model: Models::DynamicZones::DynamicZone, key: :pageContent}
        ]
      end

      def self.resource_key = "web-pages"

      def self.graphql_key = "webPages"
    end
  end
end
