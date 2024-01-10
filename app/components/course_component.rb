# frozen_string_literal: true

class CourseComponent < ViewComponent::Base
  include ViewComponent::Translatable

  delegate :stripped_summary,
    :course_meta_icon_class,
    :course_type,
    :view_course_phrase,
    :tracking_data,
    to: :helpers

  def initialize(course:, filter:)
    @course = course
    @course_filter = filter
  end

  def get_course_tag(programme)
    return "#{programme} certificate" if %w[Primary Secondary].include?(programme)

    programme
  end
end
