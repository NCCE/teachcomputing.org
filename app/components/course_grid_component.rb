# frozen_string_literal: true

class CourseGridComponent < ViewComponent::Base
  def initialize(title:, intro:, courses:, event_category:)
    @title = title
    @intro = intro
    @courses = courses
    @event_category = event_category
  end
end
