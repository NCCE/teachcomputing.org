module Cms
  module Providers
    module Strapi
      class GraphqlClient < BaseClient
        def initialize(schema_path: nil)
          @connection = GraphqlConnection.api(schema_path:)
        end

        def all(collection_class, page, page_size, params)
          query = Queries::BaseQuery.new(collection_class)
          begin
            response = @connection.execute(query.all_query(page, page_size, params))
          rescue => e
            Sentry.capture_exception(e)
            raise ActiveRecord::RecordNotFound
          end
          raise ActiveRecord::RecordNotFound if response.errors.any?

          data = clean_aliases(response.original_hash)
          to_paginated_response(collection_class, data[:data][collection_class.graphql_key.to_sym])
        end

        def one(resource_class, resource_id = nil, preview: false, preview_key: nil)
          query = Queries::BaseQuery.new(resource_class)
          begin
            response = @connection.execute(query.single_query(resource_id))
          rescue => e
            Sentry.capture_exception(e)
            raise ActiveRecord::RecordNotFound
          end

          raise ActiveRecord::RecordNotFound if response.errors.any?

          data = clean_aliases(response.original_hash)

          results = data[:data][resource_class.graphql_key.to_sym][:data]

          raise ActiveRecord::RecordNotFound if results.empty?

          map_resource(resource_class, results.first, preview, preview_key)
        end

        # This has been created to allow for alias to be name__field_name
        # This means we can add alias that override the collision issues we found when we moved to graphql
        # but without needing to rebuild the factory
        def clean_aliases(data)
          updated_data = data.deep_transform_keys do |key|
            if key.include?("__") && !(key == "__typename")
              key.split("__").last
            else
              key
            end
          end
          updated_data.deep_symbolize_keys
        end
      end
    end
  end
end
