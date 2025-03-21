# frozen_string_literal: true

class CourseGridComponent < ViewComponent::Base
  def initialize(title:, intro:, courses:, event_category:, course_link: nil)
    @title = title
    @intro = intro
    @courses = courses
    @event_category = event_category
    @course_link = course_link
  end
end
