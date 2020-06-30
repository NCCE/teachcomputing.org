require 'spec_helper'

RSpec.describe Curriculum::Queries::Unit do
  it 'creates a request with the expected params' do
    url = Curriculum::Connection::CURRICULUM_API_URL

    stub_request(:post, url)
      .to_return(
        status: 200,
        body: {}.to_json
      )

    expect(described_class.one('some_id')).to have_requested(:post, url)
      .with(body: hash_including({'variables': {'id': 'some_id'}}))
  end
end
