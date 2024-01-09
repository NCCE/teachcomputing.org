module Achiever
  class LocationCourseSearchResult
    attr_accessor :courses,
      :courses_count,
      :radius_maxed,
      :max_radius,
      :further_results_count,
      :outside_max_radius_results_count,
      :outside_max_radius_results,
      :non_location_based_results_count
  end
end
