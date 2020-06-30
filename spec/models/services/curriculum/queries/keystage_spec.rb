require 'spec_helper'

RSpec.describe Curriculum::KeyStage do
  let(:url) {Curriculum::Connection::CURRICULUM_API_URL}

  before :each do
    stub_request(:post, url)
    .to_return(
      status: 200,
      body: {}.to_json
    )
  end

  it 'creates valid queries' do
    expect{described_class.all}.not_to raise_error
    expect{described_class.one('some_id')}.not_to raise_error
  end

  it 'creates a request with the expected params' do
    expect(described_class.one('some_id')).to have_requested(:post, url)
      .with(body: hash_including({'variables': {'id': 'some_id'}}))
  end
end
