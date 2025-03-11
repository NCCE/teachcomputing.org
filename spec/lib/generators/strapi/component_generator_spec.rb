require "rails_helper"
require "generator_spec"
require "generators/strapi/component_generator"

RSpec.describe Strapi::ComponentGenerator, type: :generator do
  let(:tmp_dir) { Rails.root.join("tmp/gen_test") }
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

    it "creates the query file" do
      expect(File).to exist(file_path("app/services/cms/providers/strapi/queries/components/blocks/gen_test.rb"))
    end

    it "creates the query test file" do
      expect(File).to exist(file_path("spec/services/cms/providers/strapi/queries/components/blocks/gen_test_spec.rb"))
    end

    it "creates data file" do
      expect(File).to exist(file_path("app/services/cms/dynamic_components/blocks/gen_test.rb"))
    end

    it "creates mock file" do
      expect(File).to exist(file_path("app/services/cms/providers/strapi/mocks/dynamic_components/blocks/gen_test.rb"))
    end

    it "creates component file" do
      expect(File).to exist(file_path("app/components/cms/gen_test_component.rb"))
      expect(File).to exist(file_path("app/components/cms/gen_test_component/gen_test_component.html.erb"))
      expect(File).to exist(file_path("spec/components/cms/gen_test_component_spec.rb"))
    end

    def file_path(file)
      "tmp/gen_test/#{file}"
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
