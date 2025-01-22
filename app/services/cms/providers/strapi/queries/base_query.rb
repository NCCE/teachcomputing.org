module Cms
  module Providers
    module Strapi
      module Queries
        class BaseQuery
          attr_accessor :resource_name, :resource_filter

          QUERY_MAPS = [
            [Models::BlogPreview, BlogPreview],
            [Models::FeaturedImage, FeaturedImage],
            [Models::Slug, Slug],
            [Models::PageTitle, Components::Blocks::PageTitle],
            [Models::SimpleTitle, SimpleField],
            [Models::TextBlock, SimpleField],
            [Models::Seo, Seo],
            [Models::DynamicZone, DynamicZone],
            [Models::Aside, Aside]
          ]

          def initialize(collection_class, resource_filter = "slug")
            @collection_class = collection_class
            @resource_name = collection_class.graphql_key
            @resource_filter = resource_filter
          end

          def find_query_map(model_class)
            QUERY_MAPS.find { _1[0] == model_class }
          end

          def build_collection_fields
            fields = []
            @collection_class.collection_attribute_mappings.each do |mapping|
              query_map = find_query_map(mapping[:model])
              fields << query_map[1].embed(mapping[:key]) if query_map
            end
            fields
          end

          def build_resource_fields
            fields = []
            @collection_class.resource_attribute_mappings.each do |mapping|
              query_map = find_query_map(mapping[:model])
              fields << query_map[1].embed(mapping[:key]) if query_map
            end
            fields
          end

          def all_query(page, page_size)
            <<~GRAPHQL.freeze
              query {
                #{resource_name}(pagination: { page: #{page}, pageSize: #{page_size} }) {
                  meta {
                    pagination {
                      page pageSize pageCount total
                    }
                  }
                  data {
                    id
                    attributes {
                      updatedAt
                      createdAt
                      publishedAt
                      #{build_collection_fields.join("\n")}
                    }
                  }
                }
              }
            GRAPHQL
          end

          def single_query(id)
            <<~GRAPHQL.freeze
              query {
                #{resource_name}(filters: { #{resource_filter}: {eq: "#{id}"}}) {
                  data {
                    id
                    attributes {
                      updatedAt
                      createdAt
                      publishedAt
                      #{build_resource_fields.join("\n")}
                    }
                  }
                }
              }
            GRAPHQL
          end
        end
      end
    end
  end
end
