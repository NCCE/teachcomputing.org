class SearchablePages::CmsBlog < SearchablePage
  include Rails.application.routes.url_helpers

  store_accessor :metadata, %i[slug]

  def url
    cms_post_path(slug)
  end
end
