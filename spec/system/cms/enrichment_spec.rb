require "rails_helper"
require "axe/rspec"

RSpec.describe("Enrichment Page", type: [:system]) do
  let(:autumn_term) { Cms::Mocks::Collections::EnrichmentCategory.generate_raw_data(name: "Autumn") }
  let(:summer_term) { Cms::Mocks::Collections::EnrichmentCategory.generate_raw_data(name: "Summer") }

  let(:ks1) { Cms::Mocks::Collections::EnrichmentCategory.generate_raw_data(name: "KS1") }
  let(:ks2) { Cms::Mocks::Collections::EnrichmentCategory.generate_raw_data(name: "KS2") }

  let(:challenge) { Cms::Mocks::Collections::EnrichmentType.generate_raw_data(name: "Challenge") }
  let(:resource) { Cms::Mocks::Collections::EnrichmentType.generate_raw_data(name: "Resource") }

  let(:enrichments) {
    {data: [
      Cms::Mocks::Collections::Enrichment.generate_raw_data(
        featured: true,
        terms: {data: [autumn_term]},
        age_groups: {data: [ks1]},
        type: {data: challenge},
        rich_title: Cms::Mocks::Text::RichBlocks.single_line("Featured Item")
      ),
      Cms::Mocks::Collections::Enrichment.generate_raw_data(
        terms: {data: [autumn_term]},
        age_groups: {data: [ks2]},
        type: {data: challenge}
      ),
      Cms::Mocks::Collections::Enrichment.generate_raw_data(
        terms: {data: [summer_term]},
        age_groups: {data: [ks1]},
        type: {data: resource}
      ),
      Cms::Mocks::Collections::Enrichment.generate_raw_data(
        terms: {data: [summer_term, autumn_term]},
        age_groups: {data: [ks1]},
        type: {data: resource}
      )
    ]}
  }

  before do
    stub_strapi_enrichment_page("primary-enrichment",
      enrichment_page: Cms::Mocks::Collections::EnrichmentPage.generate_raw_data(
        enrichments:,
        featured_section_title: "Featured enrichments"
      ))

    visit primary_enrichment_path
  end

  it "is the correct page" do
    expect(page).to have_content("Featured enrichments")
  end

  context "selecting term" do
    describe "as autumn" do
      before do
        select("Autumn", from: "term")
      end

      it "should always show featured" do
        expect(page).to have_content("Featured Item", count: 2)
      end

      it "should show correct number of enrichments" do
        expect(page).to have_css(".all-enrichments .enrichment", count: 3)
      end

      it "clearing should show correct number of enrichments" do
        expect(page).to have_content("Clear filters")
        find(".filter-counter__clear").click
        expect(page).to have_css(".all-enrichments .enrichment", count: 4)
      end
    end

    describe "as summer" do
      before do
        select("Summer", from: "term")
      end

      it "should always show featured" do
        expect(page).to have_content("Featured Item", count: 1)
      end

      it "should show correct number of enrichments" do
        expect(page).to have_css(".all-enrichments .enrichment", count: 2)
      end
    end
  end

  context "selecting age group" do
    describe "as KS1" do
      before do
        select("KS1", from: "age_group")
      end

      it "should always show featured" do
        expect(page).to have_content("Featured Item", count: 2)
      end

      it "should show correct number of enrichments" do
        expect(page).to have_css(".all-enrichments .enrichment", count: 3)
      end
    end

    describe "as KS2" do
      before do
        select("KS2", from: "age_group")
      end

      it "should always show featured" do
        expect(page).to have_content("Featured Item", count: 1)
      end

      it "should show correct number of enrichments" do
        expect(page).to have_css(".all-enrichments .enrichment", count: 1)
      end
    end
  end

  context "selecting type" do
    describe "as Challenge" do
      before do
        select("Challenge", from: "type")
      end

      it "should always show featured" do
        expect(page).to have_content("Featured Item", count: 2)
      end

      it "should show correct number of enrichments" do
        expect(page).to have_css(".all-enrichments .enrichment", count: 2)
      end
    end

    describe "as Resource" do
      before do
        select("Resource", from: "type")
      end

      it "should always show featured" do
        expect(page).to have_content("Featured Item", count: 1)
      end

      it "should show correct number of enrichments" do
        expect(page).to have_css(".all-enrichments .enrichment", count: 2)
      end
    end
  end

  context "selecting mulitple options" do
    describe "selecting KS1 age_group and Autumn term" do
      before do
        select("Autumn", from: "term")
        select("KS1", from: "age_group")
      end

      it "should always show featured" do
        expect(page).to have_content("Featured Item", count: 2)
      end

      it "should show correct number of enrichments" do
        expect(page).to have_css(".all-enrichments .enrichment", count: 2)
      end
    end
  end

  describe "selecting KS1 age_group and Autumn term and Challenge type" do
    before do
      select("Autumn", from: "term")
      select("KS1", from: "age_group")
      select("Challenge", from: "type")
    end

    it "should always show featured" do
      expect(page).to have_content("Featured Item", count: 2)
    end

    it "should show correct number of enrichments" do
      expect(page).to have_css(".all-enrichments .enrichment", count: 1)
    end
  end
end
