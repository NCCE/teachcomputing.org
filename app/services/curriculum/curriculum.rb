require "graphql/client"
require "graphql/client/http"

class Curriculum
  def self.connect
    http = GraphQL::Client::HTTP.new("#{ENV.fetch('CURRICULUM_APP_URL')}/graphql")
    schema = GraphQL::Client.load_schema("db/resource_repository_schema.json")
    client = GraphQL::Client.new(schema: schema, execute: http)
  end
end
