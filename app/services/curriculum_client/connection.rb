module CurriculumClient
  class Connection
    CURRICULUM_APP_URL = "#{ENV.fetch('CURRICULUM_APP_URL')}/graphql".freeze

    def self.connect(schema_path = nil, url = CURRICULUM_APP_URL)
      store_schema = !schema_path || Rails.cache.fetch('curriculum_schema').blank?

      @client = Graphlient::Client.new(
        url,
        headers: {
          'Content-Type': 'application/json',
          Accept: 'application/json',
          Authorization: "Bearer #{ENV.fetch('CURRICULUM_API_KEY')}"
        },
        http_options: { read_timeout: 20, write_timeout: 30 },
        schema_path:
      )

      # Trigger a schema request and rescue to provide some clarity on what's happening
      begin
        @client.schema # trigger a schema request
      rescue Faraday::ParsingError
        raise CurriculumClient::Errors::SchemaLoadError, 'Unable to retrieve the schema'
      end

      # Only cache if a schema_path isn't defined (typically for testing) or the cache was empty
      Rails.cache.write('curriculum_schema', dump_schema, expires_in: 24.hours) if store_schema

      @client
    end

    def self.dump_schema
      GraphQL::Client.dump_schema(@client.schema)&.to_json
    end
  end
end
