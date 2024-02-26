require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Client do
  let(:page_class) {
    dbl = class_double("Cms::Pages::TestPage")
    allow(dbl).to receive(:resource_attribute_mappings).and_return([
      {
        attribute: :title,
        component: CmsHeroComponent,
        value_param: :title
      },
      {
        attribute: :container,
        component: nil,
        fields: [
          {
            attribute: :cardSection,
            fields: [
              {attribute: :cardHeaderImage}
            ]
          }
        ]
      }
    ])
    allow(dbl).to receive(:resource_key).and_return("test-page")
    dbl
  }

  let(:collection_class) {
    dbl = class_double("Cms::Collections::TestCollection")
    allow(dbl).to receive(:resource_attribute_mappings).and_return([
      {
        attribute: :title,
        component: CmsHeroComponent,
        value_param: :title
      }
    ])
    allow(dbl).to receive(:resource_key).and_return("test-collection")
    allow(dbl).to receive(:required_fields).and_return(["createdAt", "updatedAt", "publishedAt"])
    allow(dbl).to receive(:sort_keys).and_return(["createdAt:desc"])
    allow(dbl).to receive(:collection_attribute_mappings).and_return({
      fields: [
        {attribute: :title},
        {attribute: :featuredImage, populate: true}
      ]
    })
    dbl
  }

  let(:client) {
    described_class.new
  }

  before do
  end

  it "calls one and returns mapped resource" do
    stub_strapi_get_single_entity("test-page")
    response = client.one(page_class, {})
    expect(response[:id]).to eq(1)
    expect(response[:attributes]).to be_a Hash
  end

  it "raises RecordNotFound for missing resource" do
    stub_strapi_not_found("test-page")
    expect do
      client.one(page_class, {})
    end.to raise_error(ActiveRecord::RecordNotFound)
  end

  context "with preview" do
    before do
      stub_strapi_get_single_entity_with_preview("test-page")
    end

    it "should return latest version when no key specified" do
      response = client.one(page_class, {}, preview: true)
      expect(response[:attributes][:versionNumber]).to eq(3)
    end

    it "should return correct value when given key" do
      response = client.one(page_class, {}, preview: true, preview_key: "1")
      expect(response[:attributes][:versionNumber]).to eq(1)
    end
  end

  it "class all and returns mapped resource" do
    stub_strapi_get_collection_entity("test-collection")
    response = client.all(collection_class, 1, 10, {})
    expect(response[:total_records]).to eq(2)
    expect(response[:page_size]).to eq(10)
    expect(response[:page_number]).to eq(1)
    expect(response[:resources]).to be_a Array
    expect(response[:resources].length).to eq(2)
  end

  context "creates populate params" do
    it "adds versions when preview requested" do
      params = client.send(:generate_populate_params, page_class, preview: true)
      expect(params).to have_value(:versions)
    end

    it "for single depth attributes" do
      params = client.send(:generate_populate_params, page_class)
      expect(params).to have_value(:title)
    end

    it "for second level attributes" do
      params = client.send(:generate_populate_params, page_class)
      expect(params).to have_key(:container)
      container_params = params[:container]
      expect(container_params).to have_key(:populate)
      expect(container_params[:populate]).to have_value(:cardSection)
    end

    it "for third level attributes" do
      params = client.send(:generate_populate_params, page_class)
      card_section_params = params[:container][:populate]
      expect(card_section_params).to have_key(:cardSection)
      expect(card_section_params[:cardSection]).to have_key(:populate)
      expect(card_section_params[:cardSection][:populate]).to have_value(:cardHeaderImage)
    end
  end

  context "processing methods" do
    it "should clean data nesting from hash" do
      processed_hash = client.send(:flatten_attributes, {
        lvl_1_key: {
          data: [
            id: 1,
            attributes: {
              test: "test"
            }
          ]
        },
        container: {
          lvl_2_key: {
            data: [
              id: 1,
              attributes: {
                field: "another test"
              }
            ]
          }
        }
      })
      expect(processed_hash[:lvl_1_key]).to be_a Array
      expect(processed_hash[:container][:lvl_2_key]).to be_a Array
    end
  end
end
