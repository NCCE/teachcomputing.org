require "rails_helper"
require "generator_spec"
require "generators/strapi/component_generator"

RSpec.describe Strapi::ComponentGenerator, type: :generator do
  let(:tmp_dir) { Rails.root.join("tmp/gen_test") }
  let(:query_file_path) { file_path("app/services/cms/providers/strapi/queries/components/blocks/gen_test.rb") }
  let(:query_test_path) { file_path("spec/services/cms/providers/strapi/queries/components/blocks/gen_test_spec.rb") }
  let(:mapping_file_path) { file_path("app/services/cms/models/dynamic_components/blocks/gen_test.rb") }
  let(:mapping_test_path) { file_path("spec/services/cms/models/dynamic_components/blocks/gen_test_spec.rb") }
  let(:mock_path) { file_path("app/services/cms/providers/strapi/mocks/dynamic_components/blocks/gen_test.rb") }

  tests Strapi::ComponentGenerator
  destination Rails.root.join("tmp/gen_test")

  before do
    FileUtils.rm_rf(tmp_dir)
    prepare_destination
  end

  after do
    FileUtils.rm_rf(tmp_dir)
  end

  context "with all arguments" do
    before do
      run_generator %w[gen_test blocks --strapi-params=title textContent]
    end

    context "query file" do
      it "is created" do
        expect(File).to exist(query_file_path)
      end

      it "should contain the component name" do
        expect(File.read(query_file_path)).to match(/ComponentBlocksGenTest/)
      end

      it "should include params" do
        expect(File.read(query_file_path)).to match(/title/)
        expect(File.read(query_file_path)).to match(/textContent/)
      end
    end

    context "query test file" do
      it "is created" do
        expect(File).to exist(query_test_path)
      end

      it "should contain the correct example" do
        expect(File.read(query_test_path)).to match(/a strapi graphql component/)
      end
    end

    context "mapping file" do
      it "is created" do
        expect(File).to exist(mapping_file_path)
      end

      it "should contain the correct component name" do
        expect(File.read(mapping_file_path)).to match(/Cms::GenTestComponent/)
      end
    end

    context "mapping test file" do
      it "is created" do
        expect(File).to exist(mapping_test_path)
      end

      it "should contain the correct component name" do
        expect(File.read(mapping_test_path)).to match(/Cms::GenTestComponent/)
      end
    end

    context "mock file" do
      it "is created" do
        expect(File).to exist(mock_path)
      end

      it "should contain strapi component name" do
        expect(File.read(mock_path)).to match(/strapi_component "blocks.gen-test"/)
      end
    end

    it "creates component file" do
      expect(File).to exist(file_path("app/components/cms/gen_test_component.rb"))
      expect(File).to exist(file_path("app/components/cms/gen_test_component/gen_test_component.html.erb"))
      expect(File).to exist(file_path("spec/components/cms/gen_test_component_spec.rb"))
    end

    def file_path(file)
      File.join(tmp_dir, file)
    end
  end

  context "with invalid type" do
    it "creates the query file" do
      expect {
        run_generator %w[gen_test not-a-type --strapi-params=title textContent]
      }.to raise_error(StandardError)
    end
  end
end
