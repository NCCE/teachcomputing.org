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
          params[:fields] = collection_view_fields(collection_class) + collection_class.required_fields
          params[:populate] = collection_view_populate(collection_class)
          params[:sort] = collection_class.sort_keys if collection_class.sort_keys.any?
          response = @connection.get(collection_class.resource_key, params)
          raise ActiveRecord::RecordNotFound unless response.status == 200
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

        def one(resource_class, params, preview: false, preview_key: nil)
          params[:populate] = generate_populate_params(resource_class, preview:)
          params[:publicationState] = "preview" if preview
          response = @connection.get(generate_url(resource_class.resource_key, params), params.except(:resource_id))
          raise ActiveRecord::RecordNotFound unless response.status == 200
          body = JSON.parse(response.body, symbolize_names: true)[:data]
          map_resource(body, preview, preview_key)
        end

        private

        def flatten_attributes attribute_hash
          # remove the nested data attributes to make parsing data easier in components
          attribute_hash.each do |k, v|
            next unless v.is_a?(Hash)
            fv = flatten_attributes(v)
            if fv.has_key? :data
              attribute_hash[k] = fv[:data]
            end
          end
        end

        def collection_view_fields(collection_class)
          collection_class.collection_attribute_mappings[:fields].select { !_1.has_key?(:populate) || _1[:populate] == false }.map { _1[:attribute] }
        end

        def collection_view_populate(collection_class)
          collection_class.collection_attribute_mappings[:fields].select { _1.has_key?(:populate) && _1[:populate] == true }.each_with_object({}).with_index do |(field, hsh), index|
            hsh[index] = field[:attribute]
          end
        end

        def generate_populate_params resource_class, preview: false
          populate_params = {}
          max_index = nil
          resource_class.resource_attribute_mappings.each_with_object(populate_params).with_index do |(component, populate), index|
            if component[:fields]
              populate[component[:attribute]] = field_populate_params(component)
            else
              populate[index] = component[:attribute]
            end
            max_index = index
          end
          if preview
            # convert preview param into strapi compliant version
            populate_params[max_index + 1] = :versions
          end
          populate_params
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

        def map_resource(data, has_preview = false, preview_key = nil)
          flat_attributes = flatten_attributes(data[:attributes])
          if has_preview && flat_attributes.has_key?(:versions) # deal with the fact plugin doesnt return versions for some models
            versions = flat_attributes[:versions]
            version_to_show = versions.find { _1[:attributes][:versionNumber].to_s == preview_key } || versions.last
            flat_attributes = version_to_show[:attributes]
          end
          {
            id: data[:id],
            attributes: flat_attributes,
            created_at: data[:attributes][:createdAt],
            updated_at: data[:attributes][:updatedAt],
            published_at: data[:attributes][:publishedAt]
          }
        end
      end
    end
  end
end
