require "rails_helper"

RSpec.describe Cms::Collections::AsideSection do
  before do
  end

  it "should have correct resource_key" do
    expect(described_class.resource_key).to eq("aside-sections")
  end

  it "should have 15 minute cache expiry" do
    expect(described_class.cache_expiry).to eq(4.hours)
  end

  it "has no collection models" do
    expect(described_class.collection_attribute_mappings).to eq([])
  end
end
