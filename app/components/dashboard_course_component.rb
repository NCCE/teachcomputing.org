# frozen_string_literal: true

class DashboardCourseComponent < ViewComponent::Base
  def initialize(achievement:)
    @achievement = achievement
  end
end
