module Cms
  module Providers
    module Strapi
      class Client
        def initialize
          @connection = Connection.api
        end

        def all(collection_class, page, page_size, params)
          strapi_params = {}
          if params[:query]
            strapi_params[:filters] = Factories::QueryFactory.generate_parameters(collection_class, params[:query])
          end
          strapi_params.merge!(generate_populate_params(collection_class.collection_attribute_mappings))
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

          body = JSON.parse(response.body, symbolize_names: true)
          {
            resources: body[:data].map { map_collection(collection_class, _1) },
            page: body[:meta][:pagination][:page],
            page_size: body[:meta][:pagination][:pageSize],
            page_number: body[:meta][:pagination][:pageCount],
            total_records: body[:meta][:pagination][:total]
          }
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
              populate[component[:key]] = params
            end
          end
          # convert preview param into strapi compliant version
          populate_params[0] = :versions if preview
          populate_params
        end

        def map_collection(collection_class, data)
          to_resource(data[:id], data[:attributes], collection_class.collection_attribute_mappings.map { process_model(_1, data[:attributes]) })
        end

        def map_resource(resource_class, data, has_preview = false, preview_key = nil)
          attributes = if has_preview && data[:attributes].has_key?(:versions) # deal with the fact plugin doesnt return versions for some models
            versions = data[:attributes][:versions][:data]
            version_to_show = versions.find { _1[:attributes][:versionNumber].to_s == preview_key } || versions.last
            version_to_show[:attributes]
          else
            data[:attributes]
          end
          to_resource(data[:id], attributes, resource_class.resource_attribute_mappings.map { process_model(_1, attributes) }, preview: has_preview)
        end

        def process_model(mapping, attributes)
          if mapping[:key]
            Factories::ModelFactory.process_model(mapping[:model], attributes[mapping[:key]])
          else
            Factories::ModelFactory.process_model(mapping[:model], attributes)
          end
        end

        def to_resource(id, attributes, data_models, preview: false)
          {
            id:,
            data_models:,
            created_at: attributes[:createdAt],
            updated_at: attributes[:updatedAt],
            published_at: preview ? DateTime.now.to_s : attributes[:publishedAt]
          }
        end
      end
    end
  end
end
