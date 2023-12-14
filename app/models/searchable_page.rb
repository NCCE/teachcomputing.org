class SearchablePage < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search, against: %i[title excerpt]

  def url
    raise NotImplementedError
  end
end
