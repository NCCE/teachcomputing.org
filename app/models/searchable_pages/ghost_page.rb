class SearchablePages::GhostPage < SearchablePage
  include Rails.application.routes.url_helpers

  store_accessor :metadata, %i[slug]

  def url
    cms_page_path(slug)
  end
end
