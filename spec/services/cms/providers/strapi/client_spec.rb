require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Client do
  let(:page_class) {
    dbl = class_double("Cms::Pages::TestPage")
    allow(dbl).to receive(:resource_attribute_mappings).and_return([
      {model: Cms::Models::SimpleTitle, key: :title}
    ])
    allow(dbl).to receive(:resource_key).and_return("test-page")
    dbl
  }

  let(:collection_class) {
    dbl = class_double("Cms::Collections::TestCollection")
    allow(dbl).to receive(:resource_attribute_mappings).and_return([
      {model: Cms::Models::SimpleTitle, key: :title}
    ])
    allow(dbl).to receive(:resource_key).and_return("test-collection")
    allow(dbl).to receive(:collection_attribute_mappings).and_return([
      {model: Cms::Models::SimpleTitle, key: :title}
    ])
    dbl
  }

  let(:client) {
    described_class.new
  }

  before do
  end

  it "calls one and returns mapped resource" do
    stub_strapi_get_single_entity("test-page")
    response = client.one(page_class)
    expect(response[:id]).to eq(1)
    expect(response[:data_models].first).to be_a Cms::Models::SimpleTitle
  end

  it "raises RecordNotFound for missing resource" do
    stub_strapi_not_found("test-page")
    expect do
      client.one(page_class)
    end.to raise_error(ActiveRecord::RecordNotFound)
  end

  context "with preview" do
    before do
      stub_strapi_get_single_entity_with_preview("test-page")
    end

    it "should return latest version when no key specified" do
      response = client.one(page_class, preview: true)
      expect(response[:data_models].first.title).to eq("Privacy Notice v3")
    end

    it "should return correct value when given key" do
      response = client.one(page_class, preview: true, preview_key: "1")
      expect(response[:data_models].first.title).to eq("Privacy Notice v1")
    end
  end

  it "class all and returns mapped resource" do
    stub_strapi_get_collection_entity("test-collection")
    response = client.all(collection_class, 1, 10, {})
    expect(response[:total_records]).to eq(5)
    expect(response[:page_size]).to eq(10)
    expect(response[:page_number]).to eq(1)
    expect(response[:resources]).to be_a Array
    expect(response[:resources].length).to eq(5)
  end

  context "creates populate params" do
    let(:mappings) {
      [
        {model: Cms::Models::SimpleTitle, key: :title},
        {model: Cms::Models::FeaturedImage, key: :featuredImage}
      ]
    }
    it "adds versions when preview requested" do
      params = client.send(:generate_populate_params, mappings, preview: true)
      expect(params).to have_value(:versions)
    end

    it "for second level attributes" do
      params = client.send(:generate_populate_params, mappings)
      expect(params).to have_key(:featuredImage)
      image_params = params[:featuredImage]
      expect(image_params).to have_key(:populate)
      expect(image_params[:populate]).to eq([:alternativeText, :caption])
    end
  end
end
