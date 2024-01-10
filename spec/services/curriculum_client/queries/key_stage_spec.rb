require "spec_helper"

RSpec.describe CurriculumClient::Queries::KeyStage do
  let(:url) { CurriculumClient::Connection::CURRICULUM_APP_URL }

  before do
    stub_a_valid_schema_request
  end

  it "creates valid queries" do
    expect { described_class.all }.not_to raise_error
    expect { described_class.one("some_id") }.not_to raise_error
  end
end
