require 'graphql/client'
require 'graphql/client/http'

module Curriculum
  class Connection
  CURRICULUM_API_URL = "#{ENV.fetch('CURRICULUM_APP_URL')}/graphql".freeze

  def self.connect(schema_path = nil, url = CURRICULUM_API_URL)
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

    raise Curriculum::Errors::SchemaLoadError if @client.schema.nil?

    if store_schema
      Rails.cache.write('curriculum_schema', dump_schema, expires_in: 24.hours)
    end

    @client
  end

  def self.dump_schema
    new_schema = GraphQL::Client.dump_schema(@client.schema)
    new_schema&.to_json
  end
end
