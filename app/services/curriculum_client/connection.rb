module CurriculumClient
  class Connection
    CURRICULUM_API_URL = "#{ENV.fetch('CURRICULUM_APP_URL')}/graphql".freeze

    def self.connect(schema_path = ENV['CURRICULUM_SCHEMA_PATH'], url = CURRICULUM_API_URL)
      schema = Rails.cache.fetch('curriculum_schema') || schema_path
      store_schema = schema_path || !schema

      @client = Graphlient::Client.new(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization' => "Bearer #{ENV['CURRICULUM_API_KEY']}"
        },
        http_options: {
          read_timeout: 20,
          write_timeout: 30
        },
        schema_path: schema
      )

      begin
        raise CurriculumClient::Errors::SchemaLoadError unless @client.schema.present?
      rescue KeyError # Workaround to more gracefully error when no schema on initial request
        raise CurriculumClient::Errors::SchemaLoadError
      end

      Rails.cache.write('curriculum_schema', dump_schema, expires_in: 24.hours) if store_schema

      @client
    end

    def self.dump_schema
      new_schema = GraphQL::Client.dump_schema(@client.schema)
      new_schema&.to_json
    end
  end
end
