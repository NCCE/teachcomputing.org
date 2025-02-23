class SearchablePageIndexingJob < ApplicationJob
  include ActionView::Helpers::TextHelper
  include CoursesHelper # Depends on TextHelper

  def perform
    now = DateTime.now
    SearchablePages::CmsBlog.delete_all
    page = 1
    per_page = 100
    loop do
      blog_search_records = Cms::Collections::Blog.all(page, per_page) # Strapi Graphql has a max limit of 100
      if blog_search_records.resources.any?
        SearchablePages::CmsBlog.insert_all(blog_search_records.resources.map { |blog| blog.to_search_record(now) })
      end
      break if (page * per_page) > blog_search_records.total_records
      page += 1
    end

    SearchablePages::CmsWebPage.delete_all
    page_search_records = Cms::Collections::WebPage.all(1, 100)
    if page_search_records.resources.any?
      SearchablePages::CmsWebPage.insert_all(page_search_records.resources.map { |page| page.to_search_record(now) })
    end
    enrichment_pages = Cms::Collections::EnrichmentPage.all(1, 10)
    if enrichment_pages.resources.any?
      SearchablePages::CmsWebPage.insert_all(enrichment_pages.resources.map { |page| page.to_search_record(now) })
    end

    courses = Achiever::Course::Template.all

    course_documents = courses.map do |course|
      {
        type: SearchablePages::Course.name,
        title: course.title,
        excerpt: stripped_summary(course.meta_description) || "",
        metadata: {stem_activity_code: course.activity_code},
        published_at: nil,
        created_at: now,
        updated_at: now
      }
    end

    SearchablePages::Course.delete_all
    SearchablePages::Course.insert_all(course_documents) unless course_documents.empty?

    site_pages = SearchableSitePages.all

    site_page_documents = site_pages.map do |site_page|
      {
        type: SearchablePages::SitePage.name,
        title: site_page[:title],
        excerpt: site_page[:excerpt],
        metadata: {url: site_page[:path]},
        published_at: nil,
        created_at: now,
        updated_at: now
      }
    end

    SearchablePages::SitePage.delete_all
    SearchablePages::SitePage.insert_all(site_page_documents) unless site_page_documents.empty?
  end
end
