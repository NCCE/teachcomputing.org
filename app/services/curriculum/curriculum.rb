require "graphql/client"
require "graphql/client/http"

class Curriculum
  def initialize
    http = GraphQL::Client::HTTP.new("https://curriculum.teachcomputing.rpfdev.com/graphql") do
      def headers(context) {} end
    end

    schema = GraphQL::Client.load_schema(http)
    client = GraphQL::Client.new(schema: schema, execute: http)
  end

  # TODO: Move queries out into separate files
  def get_key_stage
    keyStage = Curriculum::Client.parse <<-'GRAPHQL'
      query {
        keystage {
          id
          title
          description
        }
      }
    GRAPHQL
  end
end
