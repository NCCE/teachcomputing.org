module CurriculumStubs
  URL = CurriculumClient::Connection::CURRICULUM_API_URL
  SCHEMA = File.new('spec/support/curriculum/curriculum_schema.json').read.freeze

  # Validates schema requests (only useful in conjunction with calling `Curriculum.connect` directly)
  def stub_a_valid_schema_request_strict
    stub_request(:post, URL)
      .with(body: /IntrospectionQuery/)
      .to_return(status: 200, body: SCHEMA)
  end

  # Validates queries against the schema
  def stub_a_valid_schema_request
    stub_request(:post, URL)
      .to_return(status: 200, body: SCHEMA)
  end

  def stub_a_valid_request(response = { "data": {} }.to_json)
    stub_request(:post, URL)
      .to_return(
        { status: 200, body: response, headers: {} }
      )
  end
end
