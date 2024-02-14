module Cms
  module Providers
    module Strapi
      class Client
        def initialize
          @connection = Connection.api
        end

        def all(collection_class, page, page_size, params)
          params[:pagination] = {
            page:,
            pageSize: page_size
          }
          params[:fields] = collection_class.collection_view_fields + collection_class.required_fields
          response = @connection.get(collection_class.resource_key, params)
          body = JSON.parse(response.body, symbolize_names: true)
          pagination = body[:meta][:pagination]
          {
            resources: body[:data].map { map_resource(_1) },
            page: pagination[:page],
            page_size: pagination[:pageSize],
            page_number: pagination[:pageCount],
            total_records: pagination[:total]
          }
        end

        def one(resource_class, params)
          params[:populate] = generate_populate_params(resource_class)
          response = @connection.get(generate_url(resource_class.resource_key, params), params)
          body = JSON.parse(response.body, symbolize_names: true)[:data]
          map_resource(body)
        end

        private

        def generate_populate_params resource_class
          populate_params = {}
          resource_class.resource_attribute_mappings.each_with_object(populate_params)
            .with_index do |(component, populate), index|
            if component[:fields]
              populate[component[:attribute]] = field_populate_params(component)
            else
              populate[index] = component[:attribute]
            end
          end
        end

        def field_populate_params component
          component_params = {populate: {}}
          component[:fields].each_with_object(component_params).with_index do |(field, hsh), index|
            hsh[:populate][index] = field[:attribute]
            component_params[:populate][field[:attribute]] = field_populate_params(field) if field[:fields]
          end
        end

        def generate_url resource_key, params
          return "#{resource_key}/#{params[:resource_id]}" if params[:resource_id]
          resource_key
        end

        def map_resource(data)
          {
            id: data[:id],
            attributes: data[:attributes],
            created_at: data[:attributes][:createdAt],
            updated_at: data[:attributes][:updatedAt],
            published_at: data[:attributes][:publishedAt]
          }
        end
      end
    end
  end
end
