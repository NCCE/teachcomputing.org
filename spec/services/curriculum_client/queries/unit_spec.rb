require 'spec_helper'

RSpec.describe CurriculumClient::Queries::Unit do
  let(:url) { CurriculumClient::Connection::CURRICULUM_API_URL }

  before do
    stub_a_valid_schema_request
  end

  it 'creates valid queries' do
    expect { described_class.all }.not_to raise_error
    expect { described_class.one('some_id') }.not_to raise_error
  end

  it 'creates a query for a positive rating' do
    expect(described_class.add_positive_rating('an_id')).to have_requested(:post, url)
      .with(body: /addPositiveUnitRating\(id:\s\\"an_id\\"\)/)
  end

  it 'creates a query for a negative rating' do
    expect(described_class.add_negative_rating('other_id')).to have_requested(:post, url)
      .with(body: /addNegativeUnitRating\(id:\s\\"other_id\\"\)/)
  end
end
