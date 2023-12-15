class SearchablePages::SitePage < SearchablePage
  store_accessor :metadata, %i[url]
end
