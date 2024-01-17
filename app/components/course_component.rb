# frozen_string_literal: true

class CourseComponent < ViewComponent::Base
  include ViewComponent::Translatable

  delegate :stripped_summary,
    :course_meta_icon_class,
    :course_type,
    :view_course_phrase,
    :tracking_data,
    :display_programme_tag,
    to: :helpers

  def initialize(course:, filter:)
    @course = course
    @course_filter = filter
  end
end
