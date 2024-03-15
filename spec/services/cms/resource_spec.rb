require "rails_helper"

RSpec.describe Cms::Resource do
  it "resource_attribute_mappings should raise NotImplementedError" do
    expect do
      described_class.resource_attribute_mappings
    end.to raise_error(NotImplementedError)
  end

  it "resource_key should raise NotImplementedError" do
    expect do
      described_class.resource_key
    end.to raise_error(NotImplementedError)
  end

  context "when extended" do
    let(:test_class) do
      Class.new(described_class) do
        def self.resource_attribute_mappings
          [
            {model: Cms::Models::SimpleTitle, key: :title}
          ]
        end

        def self.resource_key
          "cms-resource-test"
        end
      end
    end

    it "calling get returns an object" do
      stub_strapi_get_single_entity("cms-resource-test")
      response = test_class.get
      expect(response).to be_a test_class
    end

    it "calling resource_view should return the correct component" do
      stub_strapi_get_single_entity("cms-resource-test")
      response = test_class.get
      expect(response.data_models.first).to be_a Cms::Models::SimpleTitle
    end
  end
end
