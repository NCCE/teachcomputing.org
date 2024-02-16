require "rails_helper"

RSpec.describe Cms::CollectionResource do
  it "collection_attribute_mappings should raise NotImplementedError" do
    expect do
      described_class.collection_attribute_mappings
    end.to raise_error(NotImplementedError)
  end

  context "when extended" do
    let(:test_class) do
      Class.new(described_class) do
        def self.collection_attribute_mappings
          {
            component: HeroComponent,
            fields: [
              {attribute: :title}
            ]
          }
        end

        def self.resource_attribute_mappings
          {}
        end

        def self.resource_key
          "cms-collection-resource-test"
        end
      end
    end

    it "calling all gets collection object" do
      stub_strapi_get_collection_entity("cms-collection-resource-test")
      response = test_class.all(1, 10)
      expect(response).to be_a Cms::Collection
    end

    it "calling collection_view should create component" do
      stub_strapi_get_collection_entity("cms-collection-resource-test")
      response = test_class.all(1, 10)
      resource = response.resources.first
      expect(resource.collection_view).to be_a HeroComponent
    end
  end
end
