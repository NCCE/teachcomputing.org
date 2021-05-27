# frozen_string_literal: true

class LocationSearchResultsComponent < ViewComponent::Base
  def initialize(course_filter:)
    @course_filter = course_filter
  end

  def render?
    @course_filter.location_search?
  end

  def courses_present?
    @course_filter.location_based_results.courses_count.positive?
  end

  def show_no_results_message?
    results = @course_filter.location_based_results

    return false unless results.courses_count.zero?
    return false unless results.further_results_count.zero?
    return false unless results.outside_max_radius_results_count.zero?
    return false unless results.non_location_based_results_count.zero?
    true
  end
end
