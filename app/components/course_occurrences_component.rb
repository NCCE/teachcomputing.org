# frozen_string_literal: true

class CourseOccurrencesComponent < ViewComponent::Base
  delegate :course_meta_icon_class,
    :occurrence_meta_location,
    :activity_times,
    to: :helpers
  def initialize(course:)
    @course = course
  end

  def render?
    @course.occurrences.present? && !@course.always_on
  end
end
