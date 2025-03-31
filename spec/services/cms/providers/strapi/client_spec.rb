require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Client do
  let(:page_class) {
    dbl = class_double("Cms::Pages::TestPage")
    allow(dbl).to receive(:resource_attribute_mappings).and_return([
      {model: Cms::Models::BlogComponents::SimpleTitle, key: :title}
    ])
    allow(dbl).to receive(:resource_key).and_return("test-page")
    dbl
  }

  let(:collection_class) {
    dbl = class_double("Cms::Collections::TestCollection")
    allow(dbl).to receive(:resource_attribute_mappings).and_return([
      {model: Cms::Models::BlogComponents::SimpleTitle, key: :title}
    ])
    allow(dbl).to receive(:resource_key).and_return("test-collection")
    allow(dbl).to receive(:collection_attribute_mappings).and_return([
      {model: Cms::Models::BlogComponents::SimpleTitle, key: :title}
    ])
    dbl
  }

  let(:client) {
    described_class.new
  }

  before do
    allow(Rails.application.config).to receive(:strapi_connection_type).and_return("rest")
  end

  it "calls one and returns mapped resource" do
    stub_strapi_get_single_entity("test-page")
    response = client.one(page_class)
    expect(response[:id]).to eq(1)
    expect(response[:data_models].first).to be_a Cms::Models::BlogComponents::SimpleTitle
  end

  it "calls all with query parameter adds filter" do
    stub_strapi_blog_collection_with_tag("ai")
    response = client.all(Cms::Collections::Blog, 1, 50, {query: {tag: "ai"}})
    expect(response[:resources]).to be_an_instance_of(Array)
  end

  it "raises RecordNotFound for missing resource" do
    stub_strapi_not_found("test-page")
    expect do
      client.one(page_class)
    end.to raise_error(ActiveRecord::RecordNotFound)
  end

  context "with failing connection" do
    before do
      failing_connection = double("api")
      allow(failing_connection).to receive(:get).and_raise(StandardError)
      allow(Cms::Providers::Strapi::Connection).to receive(:api).and_return(failing_connection)
      stub_strapi_get_single_entity("test-page")
      stub_strapi_blog_collection_with_tag("ai")
    end
    it "one raises RecordNotFound" do
      expect do
        client.one(page_class)
      end.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "all raises RecordNotFound" do
      expect do
        client.all(Cms::Collections::Blog, 1, 50, {query: {tag: "ai"}})
      end.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  it "raises RecordNotFound for unpublished resource" do
    stub_strapi_get_single_unpublished_blog_post("test-collection/unpublished")
    expect do
      client.one(collection_class, "unpublished")
    end.to raise_error(ActiveRecord::RecordNotFound)
  end

  it "doesn't raise RecordNotFound for unpublished resource with preview" do
    stub_strapi_get_single_unpublished_blog_post("test-collection/unpublished")
    response = client.one(collection_class, "unpublished", preview: true)
    expect(response).to be_an_instance_of(Hash)
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
        {model: Cms::Models::BlogComponents::SimpleTitle, key: :title},
        {model: Cms::Models::ImageComponents::FeaturedImage, key: :featuredImage}
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
