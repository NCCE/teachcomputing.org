require "graphql/client"
require "graphql/client/http"

class Curriculum
  SCHEMA_PATH = "db/resource_repository_schema.json"
  CURRICULUM_API_URL = "#{ENV.fetch('CURRICULUM_APP_URL')}/graphql"

  class SchemaLoadError < StandardError; end
  class ConnectionError < StandardError; end

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
      raise SchemaLoadError
    end

    client
  end

  def self.request(query, params = {}, client = nil)
    client = client || self.connect

    begin
      response = client.execute(client.parse(query), params)
    rescue Graphlient::Errors::ServerError
      raise ConnectionError.new("Unable to connect to: #{CURRICULUM_API_URL}")
    end

    response.data
  end
end
