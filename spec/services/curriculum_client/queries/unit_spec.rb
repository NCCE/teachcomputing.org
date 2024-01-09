require "rails_helper"

RSpec.describe CurriculumClient::Queries::Unit do
  let(:url) { CurriculumClient::Connection::CURRICULUM_APP_URL }

  before do
    stub_a_valid_schema_request
  end

  include_examples "rateable_query", :unit

  it "creates valid queries" do
    expect { described_class.all }.not_to raise_error
    expect { described_class.one("some_id", "some-slug") }.not_to raise_error
  end
end
