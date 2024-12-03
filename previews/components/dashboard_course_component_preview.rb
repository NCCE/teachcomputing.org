# frozen_string_literal: true

class DashboardCourseComponentPreview < ViewComponent::Preview
  def default
    achievement = Achievement.in_state(:enrolled).last.presence || FactoryBot.create(:in_progress_achievement)
    user_course_info = Achiever::Course::Delegate.find_by_achiever_contact_number(User.last.presence&.stem_achiever_contact_no)

    render DashboardCourseComponent.new(
      achievement:,
      user_course_info: user_course_info
    )
  end

  def completed_achievement
    achievement = Achievement.in_state(:complete).last.presence || FactoryBot.create(:completed_achievement)

    user_course_info = FactoryBot.build(:course_delegate)

    render DashboardCourseComponent.new(
      achievement:,
      user_course_info: [user_course_info]
    )
  end
end
