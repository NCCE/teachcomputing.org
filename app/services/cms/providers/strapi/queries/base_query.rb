module Cms
  module Providers
    module Strapi
      module Queries
        class BaseQuery
          attr_accessor :resource_name, :resource_filter

          QUERY_MAPS = {
            Models::Collections::Aside => Aside,
            Models::Collections::BlogPreview => BlogPreview,
            Models::Collections::EmailTemplate => EmailTemplate,
            Models::Collections::EnrichmentList => EnrichmentList,
            Models::Data::Slug => Slug,
            Models::Data::TextField => SimpleField,
            Models::Data::WebPagePreview => WebPagePreview,
            Models::DynamicComponents::ContentBlocks::QuestionBankForm => Components::ContentBlocks::QuestionBankForm,
            Models::DynamicZones::DynamicZone => DynamicZone,
            Models::DynamicZones::EnrichmentDynamicZone => EnrichmentDynamicZone,
            Models::DynamicZones::HomepageDynamicZone => HomepageDynamicZone,
            Models::Images::FeaturedImage => FeaturedImage,
            Models::Images::Image => Image,
            Models::Meta::FooterLinkBlock => FooterLinkBlock,
            Models::Meta::HeaderMenu => HeaderMenu,
            Models::Meta::PageTitle => PageTitle,
            Models::Meta::Seo => Seo,
            Models::Meta::SimpleTitle => SimpleField,
            Models::Text::TextBlock => SimpleField,
            Models::Text::TextBlockWithoutWrapper => SimpleField,
            Models::Meta::SiteWideBanner => SiteWideBanner
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
