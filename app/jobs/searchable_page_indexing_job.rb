class SearchablePageIndexingJob < ApplicationJob
  include ActionView::Helpers::TextHelper
  include CoursesHelper # Depends on TextHelper

  def perform
    now = DateTime.now
    SearchablePages::CmsBlog.delete_all

    all_blogs = Cms::Collections::Blog.all_records

    if all_blogs.any?
      SearchablePages::CmsBlog.insert_all(all_blogs.map { |blog| blog.to_search_record(now) })
    end

    SearchablePages::CmsWebPage.delete_all
    page_search_records = Cms::Collections::WebPage.all_records
    if page_search_records.any?
      SearchablePages::CmsWebPage.insert_all(page_search_records.map { |page| page.to_search_record(now) })
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
