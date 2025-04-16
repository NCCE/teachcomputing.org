require "rails_helper"

RSpec.describe Cms::Resource do
  let(:test_class) do
    Class.new(described_class) do
      def self.resource_attribute_mappings
        [
          {model: Cms::Models::Meta::SimpleTitle, key: :title}
        ]
      end

      def self.resource_key
        "cms-resource-test"
      end
    end
  end

  context "strapi_connection_type" do
    it "default to rest client when not specified" do
      allow(Rails.application.config).to receive(:strapi_connection_type).and_return(nil)
      expect(described_class.send(:client)).to be_a Cms::Providers::Strapi::Client
    end

    it "return rest client when set to rest" do
      allow(Rails.application.config).to receive(:strapi_connection_type).and_return("rest")
      expect(described_class.send(:client)).to be_a Cms::Providers::Strapi::Client
    end

    it "return graphql client when set to graphql" do
      allow(Rails.application.config).to receive(:strapi_connection_type).and_return("graphql")
      expect(described_class.send(:client)).to be_a Cms::Providers::Strapi::GraphqlClient
    end
  end

  context "with valid config for rest" do
    before do
      allow(Rails.application.config).to receive(:strapi_connection_type).and_return("rest")
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

      it "graphql_key should raise NotImplementedError" do
        expect do
          described_class.graphql_key
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
          expect(response.data_models.first).to be_a Cms::Models::Meta::SimpleTitle
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
                {key: :title, model: Cms::Models::Meta::SimpleTitle}
              ]
            end

            def self.resource_attribute_mappings
              [
                {key: :title, model: Cms::Models::Meta::SimpleTitle}
              ]
            end

            def self.resource_key
              "cms-collection-resource-test"
            end
          end
        end

        before do
          stub_strapi_get_collection_entity("cms-collection-resource-test")
          stub_strapi_get_single_resource("cms-collection-resource-test/test-post")
        end

        it "calling all gets collection object" do
          response = collection_class.all(1, 10)
          expect(response).to be_a Cms::Collection
        end

        it "should return collection_attribute_mappings" do
          expect(collection_class.collection_attribute_mappings).to be_a Array
        end

        describe "#param_name" do
          it "should use key as param_name" do
            expect(collection_class.param_name({key: :title, model: Cms::Models::Meta::SimpleTitle})).to eq(:title)
          end

          it "should use param_name as name when specified" do
            expect(collection_class.param_name({key: :title, model: Cms::Models::Meta::SimpleTitle, param_name: :something})).to eq(:something)
          end
        end

        describe "#param_indexes" do
          it "should include key" do
            expect(collection_class.param_indexes).to have_key(:title)
          end

          it "should set correct index" do
            expect(collection_class.param_indexes[:title]).to eq(0)
          end
        end

        it "calling collection_view should create component" do
          response = collection_class.all(1, 10)
          resource = response.resources.first
          expect(resource.data_models.first).to be_a Cms::Models::Meta::SimpleTitle
        end

        it "calling get should return single record" do
          response = collection_class.get("test-post")
          expect(response).to be_a described_class
        end

        it "should raise error for search_record" do
          response = collection_class.get("test-post")
          expect {
            response.to_search_record(DateTime.now)
          }.to raise_exception(NotImplementedError)
        end

        it "should respond_to mapping key" do
          response = collection_class.get("test-post")
          expect(response).to respond_to(:title)
        end

        it "should respond data model for mapping key" do
          response = collection_class.get("test-post")
          expect(response.title).to be_a Cms::Models::Meta::SimpleTitle
        end

        context "should cache results" do
          let(:memory_store) { ActiveSupport::Cache.lookup_store(:memory_store) }

          before do
            allow(Rails).to receive(:cache).and_return(memory_store)
            Rails.cache.clear
          end

          it "should cache result with correct key with get and id" do
            stub_strapi_get_single_resource("cms-collection-resource-test/test-post")
            collection_class.get("test-post")
            expect(Rails.cache.exist?("cms-collection-resource-test-test-post", namespace: "cms")).to be true
          end

          it "should not cache when preview supplied" do
            stub_strapi_get_single_resource("cms-collection-resource-test/test-post")
            collection_class.get("test-post", preview: true)
            expect(Rails.cache.exist?("cms-collection-resource-test-test-post", namespace: "cms")).to be false
          end

          it "should cache results for all with correct key" do
            stub_strapi_get_collection_entity("cms-collection-resource-test")
            collection_class.all(1, 10)
            expect(Rails.cache.exist?("cms-collection-resource-test-1-10", namespace: "cms")).to be true
          end

          it "clear cache should clear only paginated instances of resource keys" do
            stub_strapi_get_collection_entity("cms-collection-resource-test")
            stub_strapi_get_single_resource("cms-collection-resource-test/test-post")
            collection_class.all(1, 10)
            collection_class.get("test-post")
            collection_class.clear_cache(page_size: 10)
            expect(Rails.cache.exist?("cms-collection-resource-test-1-10", namespace: "cms")).to be false
            expect(Rails.cache.exist?("cms-collection-resource-test-test-post", namespace: "cms")).to be true
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

  describe "#all_records" do
    describe "with multiple records" do
      before do
        blogs = Array.new(210) { Cms::Mocks::Collections::Blog.generate_raw_data }

        stub_strapi_blog_collection(blogs:, page: 1, page_size: 100)
        stub_strapi_blog_collection(blogs:, page: 2, page_size: 100)
        stub_strapi_blog_collection(blogs:, page: 3, page_size: 100)
      end

      it "should return all records" do
        expect(Cms::Collections::Blog.all_records.count).to eq(210)
      end
    end

    describe "with one record" do
      before do
        blogs = [Cms::Mocks::Collections::Blog.generate_raw_data]

        stub_strapi_blog_collection(blogs:, page: 1, page_size: 100)
      end

      it "should return one record" do
        expect(Cms::Collections::Blog.all_records.count).to eq(1)
      end
    end

    describe "with no records" do
      before do
        blogs = []

        stub_strapi_blog_collection(blogs:, page: 1, page_size: 100)
      end

      it "should return one record" do
        expect(Cms::Collections::Blog.all_records.count).to eq(0)
      end
    end
  end
end
