require "graphql/client"
require "graphql/client/http"

class Curriculum::Connection
  SCHEMA_PATH = "db/resource_repository_schema.json"
  CURRICULUM_API_URL = "#{ENV.fetch('CURRICULUM_APP_URL')}/graphql"

  def self.connect(schema = SCHEMA_PATH, url = CURRICULUM_API_URL)
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

    client
  end
end
