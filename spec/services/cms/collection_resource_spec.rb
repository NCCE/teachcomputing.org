require "rails_helper"

RSpec.describe Cms::CollectionResource do
  context "when extended" do
    let(:test_class) do
      Class.new(described_class) do
        def self.collection_attribute_mappings
          [
            {key: :title, model: Cms::Models::SimpleTitle}
          ]
        end

        def self.resource_attribute_mappings
          [
            {key: :title, model: Cms::Models::SimpleTitle}
          ]
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
      expect(resource.data_models.first).to be_a Cms::Models::SimpleTitle
    end
  end
end
