# frozen_string_literal: true

class DashboardCourseComponent < ViewComponent::Base
  delegate :course_icon_class, :course_category, to: :helpers

  def initialize(achievement:)
    @achievement = achievement
  end
end
