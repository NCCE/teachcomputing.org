RSpec.shared_examples "a strapi graphql query" do |options|
  key = options[:key]
  required_fields = options[:required_fields] || []

  let(:query) {
    <<~GRAPHQL
      fragment TestData on Test {
        #{described_class.embed(key)}
      }
    GRAPHQL
  }

  let(:base_fragment) {
    parsed_fragment = GraphQL::Language::Parser.parse(query)
    parsed_fragment.definitions.find { |defn| defn.is_a?(GraphQL::Language::Nodes::FragmentDefinition) }
  }

  let(:fragment) {
    base_fragment.selections.find { _1.name == key }
  }

  let(:data_fragment) {
    fragment.selections.find { _1.name == "data" }
  }

  let(:query_attributes) {
    attributes_field = data_fragment.selections.find { _1.name == "attributes" }
    attributes_field.selections.map(&:name)
  }

  it "should include key" do
    expect(fragment).to be_truthy
  end

  it "should include data" do
    expect(data_fragment).to be_truthy
  end

  required_fields.each do |field|
    it "should include attribute #{field}" do
      expect(query_attributes).to include(field)
    end
  end
end

RSpec.shared_examples "a strapi graphql embed" do |options|
  key = options[:key]
  required_fields = options[:required_fields] || []

  let(:query) {
    <<~GRAPHQL
      fragment TestData on Test {
        #{described_class.embed(key)}
      }
    GRAPHQL
  }

  let(:base_fragment) {
    parsed_fragment = GraphQL::Language::Parser.parse(query)
    parsed_fragment.definitions.find { |defn| defn.is_a?(GraphQL::Language::Nodes::FragmentDefinition) }
  }

  let(:fragment) {
    base_fragment.selections.find { _1.name == key }
  }

  let(:query_attributes) {
    query_fragment = key.nil? ? base_fragment : fragment
    query_fragment.selections.map(&:name)
  }

  if key
    it "should include key" do
      expect(fragment).to be_truthy
    end
  end

  required_fields.each do |field|
    it "should include attribute #{field}" do
      expect(query_attributes).to include(field)
    end
  end
end

RSpec.shared_examples "a strapi graphql component" do |required_fields|
  let(:query) {
    <<~GRAPHQL
      fragment TestData on Test {
          #{described_class.fragment}
      }
    GRAPHQL
  }

  let(:base_fragment) {
    parsed_fragment = GraphQL::Language::Parser.parse(query)
    parsed_fragment.definitions.find { |defn| defn.is_a?(GraphQL::Language::Nodes::FragmentDefinition) }
  }

  let(:query_attributes) {
    base_fragment.selections.first.selections.map(&:name)
  }

  required_fields.each do |field|
    it "should include attribute #{field}" do
      expect(query_attributes).to include(field)
    end
  end
end

RSpec.shared_examples "a strapi graphql collection single query" do |required_fields|
  let(:query) { Cms::Providers::Strapi::Queries::BaseQuery.new(described_class) }

  let(:base_fragment) {
    parsed_fragment = GraphQL::Language::Parser.parse(query.single_query("test"))
    parsed_fragment.definitions.first.selections.first
  }

  let(:data_fragment) {
    base_fragment.selections.find { _1.name == "data" }
  }

  let(:query_attributes) {
    attributes_field = data_fragment.selections.find { _1.name == "attributes" }
    attributes_field.selections.map(&:name)
  }

  required_fields.each do |field|
    it "should include attribute #{field}" do
      expect(query_attributes).to include(field)
    end
  end
end

RSpec.shared_examples "a strapi graphql collection all query" do |required_fields|
  let(:query) { Cms::Providers::Strapi::Queries::BaseQuery.new(described_class) }

  let(:base_fragment) {
    parsed_fragment = GraphQL::Language::Parser.parse(query.all_query(1, 10))
    parsed_fragment.definitions.first.selections.first
  }

  let(:data_fragment) {
    base_fragment.selections.find { _1.name == "data" }
  }

  let(:query_attributes) {
    attributes_field = data_fragment.selections.find { _1.name == "attributes" }
    attributes_field.selections.map(&:name)
  }

  required_fields.each do |field|
    it "should include attribute #{field}" do
      expect(query_attributes).to include(field)
    end
  end
end
