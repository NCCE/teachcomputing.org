# frozen_string_literal: true

class Cms::CourseCardComponent < ViewComponent::Base
  delegate :course_type_short, :course_meta_icon_class,
    :course_duration_text,
    to: :helpers

  def initialize(title:, banner_text:, course:, description:, image:)
    @title = title
    @banner_text = banner_text
    @course = course
    @description = description
    @image = image
  end

  def render?
    @course.present?
  end
end
