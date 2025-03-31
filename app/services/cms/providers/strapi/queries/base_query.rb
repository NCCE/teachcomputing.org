module Cms
  module Providers
    module Strapi
      module Queries
        class BaseQuery
          attr_accessor :resource_name, :resource_filter

          QUERY_MAPS = {
            DynamicComponents::ContentBlocks::QuestionBankForm => Components::ContentBlocks::QuestionBankForm,
            Models::AsideComponents::Aside => Aside,
            Models::BlogComponents::BlogPreview => BlogPreview,
            Models::BlogComponents::SimpleTitle => SimpleField,
            Models::DynamicZoneComponents::DynamicZone => DynamicZone,
            Models::DynamicZoneComponents::EnrichmentDynamicZone => EnrichmentDynamicZone,
            Models::DynamicZoneComponents::HomepageDynamicZone => HomepageDynamicZone,
            Models::EmailTemplate => EmailTemplate,
            Models::EnrichmentComponents::EnrichmentList => EnrichmentList,
            Models::HeaderComponents::HeaderMenu => HeaderMenu,
            Models::ImageComponents::FeaturedImage => FeaturedImage,
            Models::MetaComponents::PageTitle => PageTitle,
            Models::MetaComponents::Seo => Seo,
            Models::MetaComponents::Slug => Slug,
            Models::MetaComponents::WebPagePreview => WebPagePreview,
            Models::TextComponents::TextBlock => SimpleField,
            Models::TextComponents::TextBlockWithoutWrapper => SimpleField,
            Models::TextComponents::TextField => SimpleField
          }.freeze

          def initialize(collection_class, resource_filter = "slug")
            @collection_class = collection_class
            @resource_name = collection_class.graphql_key
            @resource_filter = resource_filter
          end

          def build_collection_fields
            fields = []
            @collection_class.collection_attribute_mappings.each do |mapping|
              model_class = mapping[:model]
              fields << QUERY_MAPS[model_class].embed(mapping[:key]) if QUERY_MAPS.key?(model_class)
            end
            fields
          end

          def build_resource_fields
            fields = []
            @collection_class.resource_attribute_mappings.each do |mapping|
              model_class = mapping[:model]
              fields << QUERY_MAPS[model_class].embed(mapping[:key]) if QUERY_MAPS.key?(model_class)
            end
            fields
          end

          def all_query(page, page_size, params = {})
            pagination_options = {
              page:,
              pageSize: page_size
            }
            filters = Factories::QueryFactory.generate_parameters(@collection_class, params[:query])
            param_strings = [
              query_string(:pagination, pagination_options),
              query_string(:filters, filters),
              sort_string(@collection_class)
            ]
            <<~GRAPHQL.freeze
              query {
                #{resource_name}(#{param_strings.join(" ")}) {
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

          def single_query(id = nil)
            filters = {}
            if @collection_class.is_collection
              raise StandardError if id.nil?
              filters[resource_filter] = {eq: id}
            end
            filter_string = if filters.any?
              "(#{query_string(:filters, filters)})"
            end
            <<~GRAPHQL.freeze
              query {
                #{resource_name} #{filter_string} {
                  data {
                    #{"id" if @collection_class.is_collection}
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

          def sort_string(collection_class)
            return "sort: \"#{collection_class.sort}\"" if collection_class.sort
            ""
          end

          def query_string(key, value)
            "#{key}: #{query_value_string(value)}" unless value.empty?
          end

          def query_value_string(value)
            case value
            when String
              "\"#{value}\""
            when Hash
              "{ #{value.map { |k, v| "#{k}: #{query_value_string(v)}" }.join(", ")} }"
            else
              value.to_s
            end
          end
        end
      end
    end
  end
end
