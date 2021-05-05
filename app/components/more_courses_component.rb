# frozen_string_literal: true

class MoreCoursesComponent < ViewComponent::Base
  def initialize(course_filter:)
    @course_filter = course_filter
    @search_results = course_filter.location_based_results
  end

  def show_results_within_max?
    @search_results.radius_maxed == false && @search_results.further_results_count.positive?
  end

  def courses_present?
    @course_filter.location_based_results.courses_count.positive?
  end

  def show_nationwide_results?
    # TODO: remove or re-implement after user testing
    # (@search_results.radius_maxed == true || @search_results.further_results_count.zero?) &&
    #   @search_results.outside_max_radius_results_count.positive?
    false
  end

  def no_more_results?
    # TODO: remove or re-implement after user testing
    # @search_results.further_results_count.zero? &&
      # @search_results.outside_max_radius_results_count.zero?
    false
  end
end
