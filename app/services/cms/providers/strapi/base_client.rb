module Cms
  module Providers
    module Strapi
      class BaseClient
        private

        def to_paginated_response(collection_class, data)
          items = data.is_a?(Array) ? data : data[:data]
          pagination = data.is_a?(Hash) ? (data.dig(:meta, :pagination) || {}) : {}
          {
            resources: items.map { map_collection(collection_class, _1) },
            page: pagination[:page] || 1,
            page_size: pagination[:pageSize] || items.size,
            page_number: pagination[:pageCount] || 1,
            total_records: pagination[:total] || items.size
          }
        end

        def map_collection(collection_class, data)
          to_resource(data[:documentId] || data[:id], data, process_models(collection_class.collection_attribute_mappings, data))
        end

        def map_resource(resource_class, data, has_preview = false, preview_key = nil)
          attributes = if has_preview && data.key?(:versions)
            versions = data[:versions]
            version_to_show = versions.find { _1[:versionNumber].to_s == preview_key } || versions.last
            version_to_show
          else
            data
          end

          raise ActiveRecord::RecordNotFound if !has_preview && attributes[:publishedAt].blank?

          to_resource(data[:documentId] || data[:id], attributes, process_models(resource_class.resource_attribute_mappings, attributes), preview: has_preview)
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
