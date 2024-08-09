# frozen_string_literal: true

class CpdCourseListComponent < ViewComponent::Base
  delegate :activity_icon_class,
    :activity_type,
    to: :helpers

  def initialize(current_user:, courses:, show_seperator: false)
    @current_user = current_user
    @courses = courses
    @show_seperator = show_seperator
  end
end
