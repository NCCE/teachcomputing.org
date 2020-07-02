require "graphql/client"
require "graphql/client/http"

class Curriculum::Request
  def self.run(query, params = {}, client = nil)
    client = client || Curriculum::Connection.connect

    if (!client.is_a?(Graphlient::Client))
      raise Curriculum::Errors::ConnectionError.new("Invalid or missing Graphlient::Client, unable to connect")
    end

    begin
      response = client.execute(client.parse(query), params)
    rescue Graphlient::Errors::ServerError
      raise Curriculum::Errors::ConnectionError.new("Unable to connect to: #{Curriculum::Connection::CURRICULUM_API_URL}")
    end

    response.data
  end
end
