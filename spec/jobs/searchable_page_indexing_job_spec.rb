require "rails_helper"

RSpec.describe SearchablePageIndexingJob, type: :job do
  let(:blog_excerpt) { Faker::Lorem.paragraph }
  let(:page_excerpt) { Faker::Lorem.paragraph }
  let(:enrichment_excerpt) { Faker::Lorem.paragraph }
  describe "#perform" do
    it "should clear out any old posts and pages" do
      stub_strapi_get_empty_collection_entity("blogs")
      stub_strapi_get_empty_collection_entity("web-pages")
      stub_strapi_get_empty_collection_entity("enrichment-pages")

      create_list(:searchable_pages_cms_web_page, 5)
      create_list(:searchable_pages_cms_blog, 4)
      create_list(:searchable_pages_course, 7)
      create_list(:searchable_pages_site_page, 8)

      expect(SearchablePages::CmsWebPage.count).to eq 5
      expect(SearchablePages::CmsBlog.count).to eq 4
      expect(SearchablePages::Course.count).to eq 7
      expect(SearchablePages::SitePage.count).to eq 8

      allow(SearchableSitePages).to receive(:all).and_return([])
      allow(Achiever::Course::Template).to receive(:all).and_return([])

      SearchablePageIndexingJob.perform_now

      expect(SearchablePages::CmsWebPage.count).to eq 0
      expect(SearchablePages::CmsBlog.count).to eq 0
      expect(SearchablePages::Course.count).to eq 0
      expect(SearchablePages::SitePage.count).to eq 0
    end

    it "should create searchable pages if they are pulled from strapi" do
      blogs = Array.new(210) { Cms::Mocks::Collections::Blog.generate_raw_data }
      blogs << Cms::Mocks::Collections::Blog.generate_raw_data(slug: "tech-for-success",
        excerpt: blog_excerpt,
        title: "Education and industry unite at key event championing gender equity in computer science")

      web_pages = [Cms::Mocks::Collections::WebPage.generate_raw_data(
        slug: "test-page",
        seo: Cms::Mocks::MetaComponents::Seo.generate_data(title: "Test Page", description: page_excerpt)
      )]
      web_pages += Array.new(2) { Cms::Mocks::Collections::WebPage.generate_raw_data }

      enrichment_pages = [Cms::Mocks::EnrichmentComponents::EnrichmentPage.generate_raw_data(
        slug: "enrichment-test",
        seo: Cms::Mocks::MetaComponents::Seo.generate_data(title: "Enrichment Test", description: enrichment_excerpt)
      )]

      stub_strapi_blog_collection(blogs:, page: 1, page_size: 100)
      stub_strapi_blog_collection(blogs:, page: 2, page_size: 100)
      stub_strapi_blog_collection(blogs:, page: 3, page_size: 100)
      stub_strapi_web_page_collection(web_pages:)
      stub_strapi_enrichment_collection(enrichment_pages:)

      allow(SearchableSitePages).to receive(:all).and_return([
        {
          title: "Sitey page",
          excerpt: "sitey excerpt",
          path: "/foobarbaz"
        }
      ])
      allow(Achiever::Course::Template).to receive(:all).and_return([
        OpenStruct.new(
          title: "Achiever Course",
          meta_description: "achiever description",
          activity_code: "CP123"
        )
      ])

      SearchablePageIndexingJob.perform_now

      expect(SearchablePages::CmsBlog.count).to eq(211) # 210 in generator + one fixed
      expect(SearchablePages::CmsWebPage.count).to eq(4) # three web pages + one enrichment page

      blog_test = SearchablePages::CmsBlog.find_by(title: "Education and industry unite at key event championing gender equity in computer science")
      expect(blog_test).to be_present
      expect(blog_test.excerpt).to eq blog_excerpt
      expect(blog_test.slug).to eq "tech-for-success"

      page_test = SearchablePages::CmsWebPage.find_by(title: "Test Page")
      expect(page_test).to be_present
      expect(page_test.excerpt).to eq page_excerpt
      expect(page_test.slug).to eq "test-page"

      enrichment_page_test = SearchablePages::CmsWebPage.find_by(title: "Enrichment Test")
      expect(enrichment_page_test).to be_present
      expect(enrichment_page_test.excerpt).to eq enrichment_excerpt
      expect(enrichment_page_test.slug).to eq "enrichment-test"

      expect(SearchablePages::SitePage.first.title).to eq "Sitey page"
      expect(SearchablePages::SitePage.first.excerpt).to eq "sitey excerpt"
      expect(SearchablePages::SitePage.first.url).to eq "/foobarbaz"

      expect(SearchablePages::Course.first.title).to eq "Achiever Course"
      expect(SearchablePages::Course.first.excerpt).to eq "achiever description"
      expect(SearchablePages::Course.first.stem_activity_code).to eq "CP123"
    end

    it "should create them all at the same time" do
      stub_strapi_blog_collection
      stub_strapi_web_page_collection
      stub_strapi_enrichment_collection

      allow(SearchableSitePages).to receive(:all).and_return([
        {
          title: "Sitey page",
          excerpt: "sitey excerpt",
          url: "/foobarbaz"
        }
      ])
      allow(Achiever::Course::Template).to receive(:all).and_return([
        OpenStruct.new(
          title: "Achiever Course",
          meta_description: "achiever description",
          activity_code: "CP123"
        )
      ])

      SearchablePageIndexingJob.perform_now

      expect(SearchablePages::CmsBlog.first.created_at).to eq SearchablePages::CmsWebPage.first.created_at
      expect(SearchablePages::SitePage.first.created_at).to eq SearchablePages::Course.first.created_at
      expect(SearchablePages::CmsWebPage.first.created_at).to eq SearchablePages::SitePage.first.created_at
    end
  end
end
