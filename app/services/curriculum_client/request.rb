module CurriculumClient
  class Request
    def self.run(query:, client: nil, params: {}, cache_key: nil)
      raise CurriculumClient::Errors::ConnectionError, "Invalid or missing Graphlient::Client, unable to connect" unless client.is_a?(Graphlient::Client)

      raise CurriculumClient::Errors::UnparsedQuery, "Invalid query, it must be parsed prior to making a request" unless query.is_a?(GraphQL::Client::OperationDefinition)

      return fetch_data(query, client, params) if cache_key.blank?

      Rails.cache.fetch(
        cache_key,
        expires_in: 12.hours,
        race_condition_ttl: 20.seconds,
        namespace: "curriculum"
      ) do
        fetch_data(query, client, params)
      end
    # Handle 404s gracefully...
    rescue Graphlient::Errors::ExecutionError => e
      raise ActionController::RoutingError, e.message if e.message.include?("not found")

      raise
    end

    def self.fetch_data(query, client, params)
      json_response = client.execute(query, params)
        .data
        .to_h
        .deep_transform_keys { |key| key.to_s.underscore }
        .to_json

      JSON.parse(json_response, object_class: OpenStruct)
    end
  end
end
