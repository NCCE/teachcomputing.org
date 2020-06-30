require 'spec_helper'

RSpec.describe Curriculum::Queries::Assessment do
  let(:url) {Curriculum::Connection::CURRICULUM_API_URL}

  before :each do
    stub_request(:post, url)
    .to_return(
      status: 200,
      body: {}.to_json
    )
  end

  fit 'creates valid queries' do
    expect{described_class.all}.not_to raise_error
    expect{described_class.one('some_id')}.not_to raise_error
  end
end
