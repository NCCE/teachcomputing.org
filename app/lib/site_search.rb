module SiteSearch
  QUERY_EXPIRY = 30.minutes

  def self.search(query, order: nil)
    results = SearchablePage.search(query)

    case order
    when :published_newest
      SearchablePage.where(id: results).order(published_at: :desc)
    when :published_oldest
      SearchablePage.where(id: results).order(published_at: :asc)
    else
      results
    end
  end
end
