module Cms
  module Providers
    module Strapi
      class Client < BaseClient
        def initialize
          @connection = Connection.api
        end

        def all(collection_class, page, page_size, params)
          strapi_params = {}
          if params[:query]
            strapi_params[:filters] = Factories::QueryFactory.generate_parameters(collection_class, params[:query])
          end
          strapi_params.deep_merge!(generate_populate_params(collection_class.collection_attribute_mappings))
          strapi_params[:pagination] = {
            page:,
            pageSize: page_size
          }
          begin
            response = @connection.get(collection_class.resource_key, strapi_params)
          rescue => e
            Sentry.capture_exception(e)
            raise ActiveRecord::RecordNotFound
          end

          raise ActiveRecord::RecordNotFound unless response.status == 200

          to_paginated_response(collection_class, JSON.parse(response.body, symbolize_names: true))
        end

        def one(resource_class, resource_id = nil, preview: false, preview_key: nil)
          params = {
            populate: generate_populate_params(resource_class.resource_attribute_mappings, preview:)
          }
          params[:publicationState] = "preview" if preview

          begin
            response = @connection.get(generate_url(resource_class.resource_key, resource_id), params)
          rescue => e
            Sentry.capture_exception(e)
            raise ActiveRecord::RecordNotFound
          end

          raise ActiveRecord::RecordNotFound unless response.status == 200

          body = JSON.parse(response.body, symbolize_names: true)[:data]
          map_resource(resource_class, body, preview, preview_key)
        end

        private

        def generate_url(resource_key, resource_id = nil)
          return "#{resource_key}/#{resource_id}" if resource_id
          resource_key
        end

        def generate_populate_params(mappings, preview: false)
          populate_params = mappings.each_with_object({}) do |component, populate|
            if (params = Factories::ParameterFactory.generate_parameters(component[:model]))
              if component[:key]
                populate[component[:key]] = params
              else
                populate.merge!(params)
              end
            end
          end
          # convert preview param into strapi compliant version
          populate_params[0] = :versions if preview
          populate_params
        end
      end
    end
  end
end
