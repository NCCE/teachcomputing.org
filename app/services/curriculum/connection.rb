require "graphql/client"
require "graphql/client/http"

class Curriculum::Connection
  CURRICULUM_API_URL = "#{ENV.fetch('CURRICULUM_APP_URL')}/graphql"

  def self.connect(schema_path = nil, url = CURRICULUM_API_URL)
    schema = Rails.cache.fetch('curriculum_schema') || schema_path
    store_schema = schema_path || !schema

    client = Graphlient::Client.new(url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      http_options: {
        read_timeout: 20,
        write_timeout: 30
      },
      schema_path: schema
    )

    if (client.schema == nil)
      raise Curriculum::Errors::SchemaLoadError
    end

    if (store_schema)
      new_schema = GraphQL::Client.dump_schema(client.http)
      Rails.cache.write('curriculum_schema', new_schema, :expires_in => 24.hours)
    end

    client
  end
end
