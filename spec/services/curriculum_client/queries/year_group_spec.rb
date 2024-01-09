require "rails_helper"

RSpec.describe CurriculumClient::Queries::YearGroup do
  before do
    stub_a_valid_schema_request
  end

  it "creates valid queries" do
    expect { described_class.all }.not_to raise_error
    expect { described_class.one("a-slippery-slug") }.not_to raise_error
  end
end
