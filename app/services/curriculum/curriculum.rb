require "graphql/client"
require "graphql/client/http"

class Curriculum
  class QueryError < StandardError; end

  HTTP = GraphQL::Client::HTTP.new("#{ENV.fetch('CURRICULUM_APP_URL')}/graphql") do
    def headers(context)
      {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      }
    end
  end

  begin
    Schema = GraphQL::Client.load_schema("db/resource_repository_schema.json")
    Client = GraphQL::Client.new(schema: Schema, execute: HTTP)
  rescue Errno::ECONNREFUSED
    raise 'Unable to load the schema.'
  end

  def self.request(query, id = nil)
    response = Client.query(query, variables: {:id => id})
    if response.errors.any?
      raise QueryError.new(response.errors[:data].join(", "))
    else
      response.data
    end
  end
end
