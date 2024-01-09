module CurriculumClient
  class Connection
    CURRICULUM_APP_URL = "#{ENV.fetch("CURRICULUM_APP_URL")}/graphql".freeze

    def self.connect(schema_path = nil, url = CURRICULUM_APP_URL)
      @client = Graphlient::Client.new(
        url,
        headers: {
          "Content-Type": "application/json",
          Accept: "application/json",
          Authorization: "Bearer #{ENV.fetch("CURRICULUM_API_KEY")}"
        },
        http_options: {read_timeout: 20, write_timeout: 30},
        schema_path:
      )

      # Trigger a schema request and rescue to provide some clarity on what's happening, this issue appears to have
      # been fixed in 0.7 of Graphlient, however a dependency issue prevents the update (08/03/23).
      begin
        @client.schema # trigger a schema request
      rescue Faraday::ParsingError
        raise CurriculumClient::Errors::SchemaLoadError, "Unable to retrieve the schema"
      end

      @client
    end

    def self.dump_schema
      GraphQL::Client.dump_schema(@client.schema)&.to_json
    end
  end
end
