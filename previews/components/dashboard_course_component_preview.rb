# frozen_string_literal: true

class DashboardCourseComponentPreview < ViewComponent::Preview
  def default
    user = FactoryBot.build(:user)
    activity = FactoryBot.build(:activity, stem_activity_code: "CP101")
    achievement = FactoryBot.build(:achievement, user:, activity:, updated_at: "10/07/2019 00:00:00")
    user_course_info = FactoryBot.build(:course_delegate)

    render DashboardCourseComponent.new(
      achievement: achievement,
      user_course_info: [user_course_info]
    )
  end
end
