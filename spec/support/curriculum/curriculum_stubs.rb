module CurriculumStubs
  URL = Curriculum::Connection::CURRICULUM_API_URL

  def stub_a_valid_schema_request
    # Expects a valid schema to exist in :schema
    stub_request(:post, URL)
    .to_return(
      status: 200,
      body: File.new('spec/support/curriculum/curriculum_schema.json')
    )
  end
end
