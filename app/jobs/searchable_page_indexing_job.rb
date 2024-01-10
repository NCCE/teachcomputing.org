class SearchablePageIndexingJob < ApplicationJob
  include ActionView::Helpers::TextHelper
  include CoursesHelper # Depends on TextHelper

  def perform
    ghost = Ghost.new

    now = DateTime.now

    ghost_posts = ghost.get_posts
    ghost_post_documents = ghost_posts["posts"].map do |post|
      {
        type: SearchablePages::GhostPost.name,
        title: post["title"],
        excerpt: post["custom_excerpt"] || post["excerpt"],
        metadata: {slug: post["slug"]},
        published_at: post["published_at"],
        created_at: now,
        updated_at: now
      }
    end

    SearchablePages::GhostPost.delete_all
    SearchablePages::GhostPost.insert_all(ghost_post_documents) unless ghost_post_documents.empty?

    ghost_pages = ghost.get_pages

    ghost_page_documents = ghost_pages["pages"].map do |post|
      {
        type: SearchablePages::GhostPage.name,
        title: post["title"],
        excerpt: post["custom_excerpt"] || post["excerpt"],
        metadata: {slug: post["slug"]},
        published_at: post["published_at"],
        created_at: now,
        updated_at: now
      }
    end

    SearchablePages::GhostPage.delete_all
    SearchablePages::GhostPage.insert_all(ghost_page_documents) unless ghost_page_documents.empty?

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
