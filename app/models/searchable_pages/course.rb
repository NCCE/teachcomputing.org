class SearchablePages::Course < SearchablePage
  include Rails.application.routes.url_helpers

  store_accessor :metadata, %i[stem_activity_code]

  def url
    course_path(stem_activity_code)
  end
end
