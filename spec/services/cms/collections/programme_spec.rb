require "rails_helper"

RSpec.describe Cms::Collections::Programme do
  it "should have correct resource_key" do
    expect(described_class.resource_key).to eq("programmes")
  end

  it "should have 15 minute cache expiry" do
    expect(described_class.cache_expiry).to eq(15.minutes)
  end

  it "defines not collection attribute mappings" do
    expect(described_class.collection_attribute_mappings).to eq([])
  end

  context "slug" do
    let(:slug) { "programme-resource-test" }
    let!(:programme) { create(:programme, slug:) }
    before do
      mock_data = Cms::Mocks::Programme.generate_raw_data(slug:)
      stub_strapi_programme(slug, programme: mock_data)
    end

    it "should return correctly for single page" do
      cms_programme = described_class.get(slug)
      expect(cms_programme.slug.slug).to eq(slug)
    end

    it "should raise error for search records" do
      cms_programme = described_class.get(slug)
      expect {
        cms_programme.to_search_record(DateTime.now)
      }.to raise_exception(NotImplementedError)
    end
  end

  it_should_behave_like "a strapi graphql collection single query", %w[statusPendingTitle statusPendingText statusCompletedTitle statusCompletedText]
end
