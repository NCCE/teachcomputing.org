# frozen_string_literal: true

class DashboardCourseComponent < ViewComponent::Base
  delegate :course_icon_class,
    :course_category,
    :stem_course_details,
    :get_date_string,
    :course_start_date,
    :online_course_availability,
    :started?,
    to: :helpers

  def initialize(achievement:, user_course_info:)
    @achievement = achievement
    @user_course_info = user_course_info
  end
end
