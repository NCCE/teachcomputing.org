require "graphql/client"
require "graphql/client/http"

class Curriculum
  HTTP = GraphQL::Client::HTTP.new("#{ENV.fetch('CURRICULUM_APP_URL')}/graphql")
  Schema = GraphQL::Client.load_schema("db/resource_repository_schema.json")
  Client = GraphQL::Client.new(schema: Schema, execute: HTTP)
end
