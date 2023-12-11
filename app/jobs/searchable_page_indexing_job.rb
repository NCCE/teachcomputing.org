class SearchablePageIndexingJob < ApplicationJob
  def perform
    ghost = Ghost.new

    now = DateTime.now

    ghost_posts = ghost.get_posts
    ghost_post_documents = ghost_posts['posts'].map do |post|
      {
        type: SearchablePages::GhostPost.name,
        title: post['title'],
        excerpt: post['custom_excerpt'] || post['excerpt'],
        metadata: { slug: post['slug'] },
        published_at: post['published_at'],
        created_at: now,
        updated_at: now
      }
    end

    SearchablePages::GhostPost.delete_all
    SearchablePages::GhostPost.insert_all(ghost_post_documents) unless ghost_post_documents.empty?

    ghost_pages = ghost.get_pages

    ghost_page_documents = ghost_pages['pages'].map do |post|
      {
        type: SearchablePages::GhostPage.name,
        title: post['title'],
        excerpt: post['custom_excerpt'] || post['excerpt'],
        metadata: { slug: post['slug'] },
        published_at: post['published_at'],
        created_at: now,
        updated_at: now
      }
    end

    SearchablePages::GhostPage.delete_all
    SearchablePages::GhostPage.insert_all(ghost_page_documents) unless ghost_page_documents.empty?
  end
end
