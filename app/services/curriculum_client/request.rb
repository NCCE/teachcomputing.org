module CurriculumClient
  class Request
    def self.run(query, client = nil, params = {})
      unless client.is_a?(Graphlient::Client)
        raise CurriculumClient::Errors::ConnectionError, 'Invalid or missing Graphlient::Client, unable to connect'
      end

      unless query.is_a?(GraphQL::Client::OperationDefinition)
        raise CurriculumClient::Errors::UnparsedQuery, 'Invalid query, it must be parsed prior to making a request'
      end

      begin
        response = client.execute(query, params)
      rescue Graphlient::Errors::ExecutionError => e
        # Graphlient still does not support the graphql @extensions hash. See: http://spec.graphql.org/June2018/#example-fce18
        extensions = e.response.original_hash['errors'][0]['extensions']
        raise ActiveRecord::RecordNotFound, e.message if extensions['code'] == :not_found.to_s

        raise # Don't prevent other ExecutionErrors from being raised
      rescue Graphlient::Errors::ServerError => e
        case e.status_code
        when 404
          raise CurriculumClient::Errors::RecordNotFound, e.message
        else
          raise CurriculumClient::Errors::ConnectionError,
                "Unable to connect to: #{CurriculumClient::Connection::CURRICULUM_API_URL}. Error: #{e.message} (#{e.status_code})"
        end
      end

      response.data
    end
  end
end
