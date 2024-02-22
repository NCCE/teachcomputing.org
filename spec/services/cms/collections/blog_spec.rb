require "rails_helper"

RSpec.describe Cms::Collections::Blog do
  before do
  end

  it "should include required mappings" do
    attributes = %i[title content featuredImage seo]
    attributes.each do |attribute|
      expect(described_class.resource_attribute_mappings.any? { _1[:attribute] == attribute }).to eq(true)
    end
  end

  it "should have correct resource_key" do
    expect(described_class.resource_key).to eq("blogs")
  end
end
