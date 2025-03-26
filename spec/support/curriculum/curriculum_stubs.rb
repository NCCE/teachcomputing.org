module CurriculumStubs
  URL = CurriculumClient::Connection::CURRICULUM_APP_URL
  SCHEMA = File.new("spec/support/curriculum/curriculum_schema.json").read.freeze
  DEFAULT_BODY = {data: {}}.to_json

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

  def stub_an_invalid_request(status = 404)
    stub_request(:post, URL)
      .to_return(
        {status:, body: "{}", headers: {}}
      )
  end

  def stub_a_valid_request(response = DEFAULT_BODY)
    stub_request(:post, URL)
      .to_return(
        {status: 200, body: response, headers: {}}
      )
  end

  def stub_a_valid_request_with_redirect(response = DEFAULT_BODY)
    stub_request(:post, URL)
      .to_return( # First return an empty redirect
        {status: 200, body: {data: {redirect: []}}.to_json, headers: {}}
      )
      .to_return( # ...then the lesson
        {status: 200, body: response, headers: {}}
      )
  end

  def stub_a_rating_request(rating_id)
    stub_request(:post, URL)
      .to_return(
        {
          status: 200,
          body: {
            data: {
              add_positive_lesson_rating: {id: rating_id},
              add_negative_lesson_rating: {id: rating_id},
              add_positive_unit_rating: {id: rating_id},
              add_negative_unit_rating: {id: rating_id}
            }
          }.to_json,
          headers: {}
        }
      )
  end
end
