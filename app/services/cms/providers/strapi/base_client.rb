module Cms
  module Providers
    module Strapi
      class BaseClient
        private

        def to_paginated_response(collection_class, data)
          {
            resources: data[:data].map { map_collection(collection_class, _1) },
            page: data[:meta][:pagination][:page],
            page_size: data[:meta][:pagination][:pageSize],
            page_number: data[:meta][:pagination][:pageCount],
            total_records: data[:meta][:pagination][:total]
          }
        end

        def map_collection(collection_class, data)
          to_resource(data[:id], data[:attributes], process_models(collection_class.collection_attribute_mappings, data[:attributes]))
        end

        def map_resource(resource_class, data, has_preview = false, preview_key = nil)
          attributes = if has_preview && data[:attributes].has_key?(:versions) # deal with the fact plugin doesnt return versions for some models
            versions = data[:attributes][:versions][:data]
            version_to_show = versions.find { _1[:attributes][:versionNumber].to_s == preview_key } || versions.last
            version_to_show[:attributes]
          else
            data[:attributes]
          end

          raise ActiveRecord::RecordNotFound if !has_preview && attributes[:publishedAt].blank?

          to_resource(data[:id], attributes, process_models(resource_class.resource_attribute_mappings, attributes), preview: has_preview)
        end

        def process_models(mappings, data)
          mappings.each_with_object([]) do |mapping, data_models|
            data_models << Factories::ModelFactory.process_model(mapping, data)
          end
        end

        def to_resource(id, attributes, data_models, preview: false)
          {
            id:,
            data_models: data_models.compact, # remove any nil data models
            created_at: attributes[:createdAt],
            updated_at: attributes[:updatedAt],
            published_at: preview ? DateTime.now.to_s : attributes[:publishedAt]
          }
        end
      end
    end
  end
end
