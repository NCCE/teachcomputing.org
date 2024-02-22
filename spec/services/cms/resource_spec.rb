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
            {
              attribute: :title,
              component: CmsHeroComponent,
              value_param: :title
            }
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
      expect(response.resource_view(test_class.resource_attribute_mappings.first)).to be_a CmsHeroComponent
    end

    context "when instantiated" do
      it "calling attribute_mapping should return mapping" do
        instance = test_class.new(id: "1", attributes: {title: "test"}, created_at: DateTime.now.to_s,
          updated_at: DateTime.now.to_s, published_at: DateTime.now.to_s)
        mapping = instance.attribute_mapping(:title)
        expect(mapping[:component]).to be(CmsHeroComponent)
      end
    end
  end
end
