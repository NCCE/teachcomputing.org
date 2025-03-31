require "rails_helper"

RSpec.describe Cms::Collections::WebPage do
  let(:required_models) {
    [Cms::Models::MetaComponents::Slug, Cms::Models::MetaComponents::PageTitle, Cms::Models::MetaComponents::Seo, Cms::Models::DynamicZoneComponents::DynamicZone]
  }

  before do
  end

  it "should have correct resource_key" do
    expect(described_class.resource_key).to eq("web-pages")
  end

  it "should have 4 hour cache expiry" do
    expect(described_class.cache_expiry).to eq(4.hours)
  end

  it "should have the correct models" do
    models = described_class.resource_attribute_mappings.collect { _1[:model] }
    expect(models).to eq(required_models)
  end

  context "slug" do
    before do
      web_pages = [
        Cms::Mocks::WebPage.generate_raw_data(slug: "test-page-slug"),
        Cms::Mocks::WebPage.generate_raw_data(slug: "second-test-page-slug")
      ]
      stub_strapi_web_page_collection(web_pages:)
    end
    it "should return correctly in collection" do
      collection = described_class.all(1, 10)
      pages = collection.resources
      expect(pages.first.slug).to eq("test-page-slug")
      expect(pages.second.slug).to eq("second-test-page-slug")
    end

    it "should return correctly for single page" do
      stub_strapi_web_page("single-page", page: Cms::Mocks::WebPage.generate_raw_data(slug: "single-page"))
      page = described_class.get("single-page")
      expect(page.slug).to eq("single-page")
    end
  end

  it_should_behave_like "a strapi graphql collection single query", %w[pageTitle pageContent]
end
