module Cms
  module Providers
    module Strapi
      class Client
        def initialize
          @connection = Connection.api
        end

        def all(collection_class, page, page_size, params)
          params.merge!(generate_populate_params(collection_class.collection_attribute_mappings))
          params[:pagination] = {
            page:,
            pageSize: page_size
          }
          response = @connection.get(collection_class.resource_key, params)

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

        def one(resource_class, params, preview: false, preview_key: nil)
          params[:populate] = generate_populate_params(resource_class.resource_attribute_mappings, preview:)
          params[:publicationState] = "preview" if preview

          response = @connection.get(generate_url(resource_class.resource_key, params), params.except(:resource_id))

          raise ActiveRecord::RecordNotFound unless response.status == 200

          body = JSON.parse(response.body, symbolize_names: true)[:data]
          map_resource(resource_class, body, preview, preview_key)
        end

        private

        def generate_populate_params(mappings, preview: false)
          populate_params = mappings.each_with_object({}) do |component, populate|
            if (params = populate_params_for(component[:model]))
              populate[component[:key]] = params
            end
          end
          if preview
            # convert preview param into strapi compliant version
            populate_params[0] = :versions
          end
          populate_params
        end

        def populate_params_for(model_class)
          if model_class == Cms::Models::Seo
            {populate: [:title, :description]}
          elsif model_class == Cms::Models::FeaturedImage
            {populate: [:alternativeText, :caption]}
          elsif model_class == Cms::Models::BlogPreview
            {
              populate: {featuredImage: {populate: [:alternativeText]}},
              fields: [:title, :excerpt, :publishDate, :slug, :publishedAt, :createdAt, :updatedAt],
              sort: ["publishDate:desc"]
            }
          end
        end

        def generate_url resource_key, params
          return "#{resource_key}/#{params[:resource_id]}" if params[:resource_id]
          resource_key
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
          to_resource(data[:id], attributes, resource_class.resource_attribute_mappings.map { process_model(_1, attributes) })
        end

        def process_model(mapping, attributes)
          if mapping[:key]
            ModelFactory.process_model(mapping[:model], attributes[mapping[:key]])
          else
            ModelFactory.process_model(mapping[:model], attributes)
          end
        end

        def to_resource(id, attributes, data_models)
          {
            id:,
            data_models:,
            created_at: attributes[:createdAt],
            updated_at: attributes[:updatedAt],
            published_at: attributes[:publishedAt]
          }
        end
      end
    end
  end
end
