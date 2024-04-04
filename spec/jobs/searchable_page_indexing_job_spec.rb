require "rails_helper"

RSpec.describe SearchablePageIndexingJob, type: :job do
  describe "#perform" do
    it "should clear out any old posts and pages" do
      stub_strapi_get_empty_collection_entity("blogs")
      stub_strapi_get_empty_collection_entity("simple-pages")

      create_list(:searchable_pages_cms_simple_page, 5)
      create_list(:searchable_pages_cms_blog, 4)
      create_list(:searchable_pages_course, 7)
      create_list(:searchable_pages_site_page, 8)

      expect(SearchablePages::CmsSimplePage.count).to eq 5
      expect(SearchablePages::CmsBlog.count).to eq 4
      expect(SearchablePages::Course.count).to eq 7
      expect(SearchablePages::SitePage.count).to eq 8

      allow(SearchableSitePages).to receive(:all).and_return([])
      allow(Achiever::Course::Template).to receive(:all).and_return([])

      SearchablePageIndexingJob.perform_now

      expect(SearchablePages::CmsSimplePage.count).to eq 0
      expect(SearchablePages::CmsBlog.count).to eq 0
      expect(SearchablePages::Course.count).to eq 0
      expect(SearchablePages::SitePage.count).to eq 0
    end

    it "should create searchable pages if they are pulled from ghost" do
      stub_strapi_blog_collection
      stub_strapi_simple_page_collection

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

      expect(SearchablePages::CmsBlog.count).to eq(5)

      blog_test = SearchablePages::CmsBlog.find_by(title: "Education and industry unite at key event championing gender equity in computer science")
      expect(blog_test).to be_present
      expect(blog_test.excerpt).to match(/^Yesterday, we were delighted/)
      expect(blog_test.slug).to eq "tech-for-success"

      expect(SearchablePages::CmsSimplePage.first.title).to eq "Test Page"
      expect(SearchablePages::CmsSimplePage.first.slug).to eq "test-page"

      expect(SearchablePages::SitePage.first.title).to eq "Sitey page"
      expect(SearchablePages::SitePage.first.excerpt).to eq "sitey excerpt"
      expect(SearchablePages::SitePage.first.url).to eq "/foobarbaz"

      expect(SearchablePages::Course.first.title).to eq "Achiever Course"
      expect(SearchablePages::Course.first.excerpt).to eq "achiever description"
      expect(SearchablePages::Course.first.stem_activity_code).to eq "CP123"
    end

    it "should create them all at the same time" do
      stub_strapi_blog_collection
      stub_strapi_simple_page_collection

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

      expect(SearchablePages::CmsBlog.first.created_at).to eq SearchablePages::CmsSimplePage.first.created_at
      expect(SearchablePages::SitePage.first.created_at).to eq SearchablePages::Course.first.created_at
      expect(SearchablePages::CmsSimplePage.first.created_at).to eq SearchablePages::SitePage.first.created_at
    end
  end
end
