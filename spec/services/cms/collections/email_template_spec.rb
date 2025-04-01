require "rails_helper"

RSpec.describe Cms::Collections::EmailTemplate do
  before do
    stub_strapi_email_template("email-template-collection-test")
  end

  it "should have correct resource_key" do
    expect(described_class.resource_key).to eq("email-templates")
  end

  it "should have 15 minute cache expiry" do
    expect(described_class.cache_expiry).to eq(15.minutes)
  end

  it "should have the correct models" do
    models = described_class.resource_attribute_mappings.collect { _1[:model] }
    expect(models).to eq([Cms::Models::EmailComponents::EmailTemplate])
  end

  describe "#template" do
    it "should return the template" do
      email_template = described_class.get("email-template-collection-test")
      expect(email_template.template).to be_instance_of(Cms::Models::EmailComponents::EmailTemplate)
    end
  end
end
