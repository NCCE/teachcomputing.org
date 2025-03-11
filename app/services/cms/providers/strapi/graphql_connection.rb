module Cms
  module Providers
    module Strapi
      class GraphqlConnection
        class << self
          def api(schema_path: nil)
            config = Rails.application.config
            @client = Graphlient::Client.new(
              config.strapi_graphql_url,
              headers: {
                "Content-Type": "application/json",
                Accept: "application/json",
                Authorization: "Bearer #{config.strapi_api_key}"
              },
              http_options: {read_timeout: 20, write_timeout: 30},
              schema_path: schema_path
            )
          end

          def dump_schema(schema_path: nil)
            api(schema_path:) # initialize client
            GraphQL::Client.dump_schema(@client.schema)&.to_json
          end
        end
      end
    end
  end
end
