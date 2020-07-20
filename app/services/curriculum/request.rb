class Curriculum::Request
  def self.run(query, client = nil, params = {})
    unless client.is_a?(Graphlient::Client)
      raise Curriculum::Errors::ConnectionError, 'Invalid or missing Graphlient::Client, unable to connect'
    end

    unless query.is_a?(GraphQL::Client::OperationDefinition)
      raise Curriculum::Errors::UnparsedQuery, 'Invalid query, it must be parsed prior to making a request'
    end

    begin
      response = client.execute(query, params)
    rescue Graphlient::Errors::ServerError
      raise Curriculum::Errors::ConnectionError, "Unable to connect to: #{Curriculum::Connection::CURRICULUM_API_URL}"
    end

    response.data
  end
end
