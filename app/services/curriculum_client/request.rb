module CurriculumClient
  class Request
    def self.run(query:, client: nil, params: {}, cache_key: nil)
      unless client.is_a?(Graphlient::Client)
        raise CurriculumClient::Errors::ConnectionError, 'Invalid or missing Graphlient::Client, unable to connect'
      end

      unless query.is_a?(GraphQL::Client::OperationDefinition)
        raise CurriculumClient::Errors::UnparsedQuery, 'Invalid query, it must be parsed prior to making a request'
      end

      begin
<<<<<<< HEAD
        return client.execute(query, params).data unless query.definition_node.operation_type == 'query'
=======
        return fetch_data(query, client, params) unless query.definition_node.operation_type == 'query'
>>>>>>> 0341a1ecef3abe348d2014a052ac745e8c6872fa

        Rails.cache.fetch(
          cache_key,
          expires_in: 12.hours,
          race_condition_ttl: 20.seconds,
          namespace: 'curriculum'
        ) do
<<<<<<< HEAD
          json_response = client.execute(query, params)
                                .data
                                .to_h
                                .deep_transform_keys { |key| key.to_s.underscore }
                                .to_json
          JSON.parse(json_response, object_class: OpenStruct)
=======
          fetch_data(query, client, params)
>>>>>>> 0341a1ecef3abe348d2014a052ac745e8c6872fa
        end
      rescue Graphlient::Errors::ExecutionError => e
        # Graphlient does not support the graphql extensions hash. See: http://spec.graphql.org/June2018/#example-fce18
        original_hash = e.response.original_hash
        extensions = original_hash['errors'][0]['extensions']
        raise ActiveRecord::RecordNotFound, e.message if extensions && extensions['code'] == :not_found.to_s

        raise # Don't prevent other ExecutionErrors from being raised
      rescue Graphlient::Errors::ServerError => e
        case e.status_code
        when 404
          raise CurriculumClient::Errors::RecordNotFound, e.message
        else
          raise CurriculumClient::Errors::ConnectionError,
                "Unable to connect to: #{CurriculumClient::Connection::CURRICULUM_APP_URL}. Error: #{e.message} (#{e.status_code})"
        end
      end
<<<<<<< HEAD
=======
    end

    def self.fetch_data(query, client, params)
      json_response = client.execute(query, params)
            .data
            .to_h
            .deep_transform_keys { |key| key.to_s.underscore }
            .to_json
      JSON.parse(json_response, object_class: OpenStruct)
>>>>>>> 0341a1ecef3abe348d2014a052ac745e8c6872fa
    end
  end
end
