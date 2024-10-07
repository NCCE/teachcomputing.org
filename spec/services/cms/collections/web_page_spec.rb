require "rails_helper"

RSpec.describe Cms::Collections::WebPage do
  let(:required_models) {
    [Cms::Models::PageTitle, Cms::Models::Seo, Cms::Models::DynamicZone]
  }

  before do
  end

  it "should have correct resource_key" do
    expect(described_class.resource_key).to eq("web-pages")
  end

  it "should have 15 minute cache expiry" do
    expect(described_class.cache_expiry).to eq(4.hours)
  end

  it "should have the correct models" do
    models = described_class.resource_attribute_mappings.collect { _1[:model] }
    expect(models).to eq(required_models)
  end
end
