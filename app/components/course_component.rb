# frozen_string_literal: true

class CourseComponent < ViewComponent::Base
  delegate :stripped_summary,
           :course_meta_icon_class,
           :course_type,
           :view_course_phrase,
           :occurrence_meta_location, # remove once sorted styles as in occurrence
           :activity_times, # remove once sorted styles as in occurrence
           to: :helpers

  def initialize(course:, filter:)
    @course = course
    @course_filter = filter
  end
end
