require "rails_helper"

RSpec.describe Cms::Collections::Blog do
  before do
  end

  it "should have correct resource_key" do
    expect(described_class.resource_key).to eq("blogs")
  end

  it "should have 30 minute cache expiry" do
    expect(described_class::CACHE_EXPIRY).to eq(30.minutes)
  end

  it "should include tag in query keys" do
    expect(described_class.query_keys).to include(:tag)
  end
end
