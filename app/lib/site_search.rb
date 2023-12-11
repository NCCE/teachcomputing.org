module SiteSearch
  QUERY_EXPIRY = 30.minutes

  def self.search(query, order: nil)
    SiteSearch::Internal.cache_in_production(
      "#{query} #{order}",
      expires_in: SiteSearch::QUERY_EXPIRY,
      namespace: 'site-search'
    ) do
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

  module Internal
    def self.cache_in_production(*args, **options, &block)
      if Rails.env.development? || Rails.env.test?
        block.call
      else
        Rails.cache.fetch(*args, **options, &block)
      end
    end
  end
end
