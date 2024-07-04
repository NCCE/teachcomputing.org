require "rails_helper"

RSpec.describe Cms::Collections::Blog do
  before do
  end

  it "should have correct resource_key" do
    expect(described_class.resource_key).to eq("blogs")
  end

  it "should have 15 minute cache expiry" do
    expect(described_class.cache_expiry).to eq(15.minutes)
  end

  it "should include tag in query keys" do
    expect(described_class.query_keys).to include(:tag)
  end
end
