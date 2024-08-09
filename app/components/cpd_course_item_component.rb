# frozen_string_literal: true

class CpdCourseItemComponent < ViewComponent::Base
  delegate :activity_icon_class,
    :activity_type,
    to: :helpers

  def initialize(activity:, current_user:)
    @activity = activity
    @current_user = current_user

    @course = Achiever::Course::Template.maybe_find_by_activity_code(activity.stem_activity_code) if activity.stem_activity_code.present?
    @achievement = current_user.achievements.to_a.find { _1.activity_id == activity.id }
  end
end
