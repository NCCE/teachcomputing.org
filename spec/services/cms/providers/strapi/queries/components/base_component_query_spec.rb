require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Queries::Components::BaseComponentQuery do
  let(:test_class) do
    Class.new(described_class) do
      def self.name = "ComponentBlocksTestComponent"

      def self.base_fields
        <<~GRAPHQL
          field1
          field2
        GRAPHQL
      end
    end
  end

  context "#name" do
    it "should raise NotImplementedError" do
      expect { described_class.name }.to raise_error(NotImplementedError)
    end
  end

  context "#base_fields" do
    it "should raise NotImplementedError" do
      expect { described_class.base_fields }.to raise_error(NotImplementedError)
    end
  end

  context "#embed" do
    it "should include embed name" do
      expect(test_class.embed("embed_name")).to include("embed_name")
    end

    it "should include field names" do
      expect(test_class.embed("embed_name")).to include("field1\nfield2")
    end
  end

  context "#fragment" do
    it "should include name" do
      expect(test_class.fragment).to include("ComponentBlocksTestComponent")
    end

    it "should include field names" do
      expect(test_class.fragment).to include("field1\nfield2")
    end
  end
end
