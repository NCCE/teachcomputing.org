require "rails_helper"

RSpec.describe Cms::Collections::WebPage do
  before do
  end

  it "should have correct resource_key" do
    expect(described_class.resource_key).to eq("web-pages")
  end

  it "should have 15 minute cache expiry" do
    expect(described_class.cache_expiry).to eq(4.hours)
  end
end