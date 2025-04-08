
require "rails_helper"

RSpec.describe Cms::Models::ContainsCached do
  before do
    stub_strapi_web_page("test-cache",
      page: Cms::Mocks::Collections::WebPage.generate_raw_data(
        page_content: [
          Cms::Mocks::DynamicComponents::Blocks::TextWithAsides.generate_raw_data(
            aside_sections: Cms::Mocks::Collections::AsideSection.generate_aside_list(aside_slugs: ['test-aside', 'other-aside'])
          ),
          Cms::Mocks::DynamicComponents::Blocks::PrimaryGlossaryTable.generate_raw_data
        ]
      )
    )

    stub_strapi_aside_section("test-aside")
    stub_strapi_aside_section("other-aside")
    records = Array.new(250) { Cms::Mocks::Collections::PrimaryGlossaryTableItems.generate_raw_data }
    stub_strapi_primary_computing_glossary_table_collection(table: records, page: 1, page_size: 100)
    stub_strapi_primary_computing_glossary_table_collection(table: records, page: 2, page_size: 100)
    stub_strapi_primary_computing_glossary_table_collection(table: records, page: 3, page_size: 100)

    Cms::Collections::WebPage.get("test-cache")
  end

  it "clear cache should clear aside" do
    expect(Cms::Collections::AsideSection).to receive(:clear_cache).with("test-aside").once
    expect(Cms::Collections::AsideSection).to receive(:clear_cache).with("other-aside").once

    Cms::Collections::WebPage.clear_cache("test-cache")
  end

  it "should clear cache on primary glossary table items" do
    expect(Cms::Collections::PrimaryGlossaryTableItems).to receive(:clear_cache).once

    Cms::Collections::WebPage.clear_cache("test-cache")
  end

  it "should clear all the keys for primary-computing-glossary-table" do
    expect(Rails.cache).to receive(:delete).with("aside-sections-test-aside", namespace: "cms").once
    expect(Rails.cache).to receive(:delete).with("aside-sections-other-aside", namespace: "cms").once
    expect(Rails.cache).to receive(:delete).with("web-pages-test-cache", namespace: "cms").once
    expect(Rails.cache).to receive(:delete).with("primary-computing-glossary-table-1-100", namespace: "cms").once
    expect(Rails.cache).to receive(:delete).with("primary-computing-glossary-table-2-100", namespace: "cms").once
    expect(Rails.cache).to receive(:delete).with("primary-computing-glossary-table-3-100", namespace: "cms").once

    Cms::Collections::WebPage.clear_cache("test-cache")
  end
end
