# frozen_string_literal: true

class MoreCoursesComponent < ViewComponent::Base
  def initialize(course_filter:, preview: false)
    @preview = preview
    @course_filter = course_filter
    @search_results = course_filter.location_based_results
  end

  def show_results_within_max?
    return true if @preview

    @search_results.radius_maxed == false && @search_results.further_results_count.positive?
  end

  def courses_present?
    @course_filter.location_based_results.courses_count.positive?
  end

  def render?
    return true if @preview
    return false if @search_results.radius_maxed
    return false unless @search_results.further_results_count.positive?
    true
  end
end
