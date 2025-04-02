require "rails_helper"

RSpec.describe Cms::Collections::EnrichmentPage do
  let(:required_models) {
    [Cms::Models::MetaComponents::Slug, Cms::Models::MetaComponents::Seo, Cms::Models::MetaComponents::PageTitle,
      Cms::Models::DynamicZoneComponents::EnrichmentDynamicZone, Cms::Models::EnrichmentComponents::EnrichmentList,
      Cms::Models::TextComponents::TextField, Cms::Models::TextComponents::TextField, Cms::Models::TextComponents::TextField,
      Cms::Models::TextComponents::TextField, Cms::Models::TextComponents::TextField]
  }

  before do
  end

  it "should have correct resource_key" do
    expect(described_class.resource_key).to eq("enrichment-pages")
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
      enrichment_pages = [
        Cms::Mocks::Collections::EnrichmentPage.generate_raw_data(slug: "test-enrichment-page-slug"),
        Cms::Mocks::Collections::EnrichmentPage.generate_raw_data(slug: "second-test-enrichment-page-slug")
      ]
      stub_strapi_enrichment_collection(enrichment_pages:)
    end
    it "should return correctly in collection" do
      collection = described_class.all(1, 10)
      pages = collection.resources
      expect(pages.first.slug).to eq("test-enrichment-page-slug")
      expect(pages.second.slug).to eq("second-test-enrichment-page-slug")
    end

    it "should return correctly for single page" do
      stub_strapi_enrichment_page("single-enrichment-page", enrichment_page: Cms::Mocks::Collections::EnrichmentPage.generate_raw_data(slug: "single-enrichment-page"))
      page = described_class.get("single-enrichment-page")
      expect(page.slug).to eq("single-enrichment-page")
    end
  end

  it_should_behave_like "a strapi graphql collection single query", %w[pageTitle content enrichments featuredSectionTitle allSectionTitle typeFilterPlaceholder termFilterPlaceholder ageGroupFilterPlaceholder]
end
