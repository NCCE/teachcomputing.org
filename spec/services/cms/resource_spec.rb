require "rails_helper"

RSpec.describe Cms::Resource do
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

  context "with valid config" do
    before do
      stub_const("ENV",
        {
          "CMS_PROVIDER" => "strapi",
          "STRAPI_API_KEY" => "strapi",
          "STRAPI_URL" => "http://strapi.teachcomputing.rpfdev.com/api"
        })
    end

    context "single resource" do
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

        it "should raise error when calling all" do
          expect do
            test_class.all(1, 20)
          end.to raise_error(Cms::Errors::NotACmsCollection)
        end

        it "should raise error when calling collection_attribute_mappings" do
          expect do
            test_class.collection_attribute_mappings
          end.to raise_error(Cms::Errors::NotACmsCollection)
        end
      end
    end

    context "collection resource" do
      let(:empty_collection_class) do
        Class.new(described_class) do
          def self.is_collection = true
        end
      end

      it "should return empty array for collection_attribute_mappings" do
        expect(empty_collection_class.collection_attribute_mappings).to eq([])
      end

      context "when extended" do
        let(:collection_class) do
          Class.new(described_class) do
            def self.is_collection = true

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
          response = collection_class.all(1, 10)
          expect(response).to be_a Cms::Collection
        end

        it "should return collection_attribute_mappings" do
          expect(collection_class.collection_attribute_mappings).to be_a Array
        end

        it "calling collection_view should create component" do
          stub_strapi_get_collection_entity("cms-collection-resource-test")
          response = collection_class.all(1, 10)
          resource = response.resources.first
          expect(resource.data_models.first).to be_a Cms::Models::SimpleTitle
        end

        it "calling get should return single record" do
          stub_strapi_get_single_blog_post("cms-collection-resource-test/test-post")
          response = collection_class.get("test-post")
          expect(response).to be_a described_class
        end

        context "should cache results" do
          let(:memory_store) { ActiveSupport::Cache.lookup_store(:memory_store) }

          before do
            allow(Rails).to receive(:cache).and_return(memory_store)
            Rails.cache.clear
          end

          it "should cache result with correct key with get and id" do
            stub_strapi_get_single_blog_post("cms-collection-resource-test/test-post")
            collection_class.get("test-post")
            expect(Rails.cache.exist?("cms-collection-resource-test-test-post", namespace: "cms")).to be true
          end

          it "should not cache when preview supplied" do
            stub_strapi_get_single_blog_post("cms-collection-resource-test/test-post")
            collection_class.get("test-post", preview: true)
            expect(Rails.cache.exist?("cms-collection-resource-test-test-post", namespace: "cms")).to be false
          end

          it "should cache results for all with correct key" do
            stub_strapi_get_collection_entity("cms-collection-resource-test")
            collection_class.all(1, 10)
            expect(Rails.cache.exist?("cms-collection-resource-test-1-10", namespace: "cms")).to be true
          end

          it "clear cache should clear all instances of resource keys" do
            stub_strapi_get_collection_entity("cms-collection-resource-test")
            stub_strapi_get_single_blog_post("cms-collection-resource-test/test-post")
            collection_class.all(1, 10)
            collection_class.get("test-post")
            collection_class.clear_cache
            expect(Rails.cache.exist?("cms-collection-resource-test-1-10", namespace: "cms")).to be false
            expect(Rails.cache.exist?("cms-collection-resource-test-test-post", namespace: "cms")).to be false
          end
        end
      end
    end
  end

  context "invalid config" do
    before do
      allow(Rails.application.config).to receive(:cms_provider).and_return(nil)
    end

    it "should raise error when no provider supplied" do
      expect do
        test_class.get
      end.to raise_error(Cms::Errors::NoCmsProviderDefined)
    end
  end
end