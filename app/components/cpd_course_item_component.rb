# frozen_string_literal: true

class CpdCourseItemComponent < ViewComponent::Base
  delegate :activity_icon_class,
    :activity_type,
    to: :helpers

  def initialize(activity:, current_user:)
    @activity = activity
    @current_user = current_user

    @course = Achiever::Course::Template.maybe_find_by_activity_code(activity.stem_activity_code) if activity.stem_activity_code.present?
    @achievements = current_user.achievements.where(activity: @activity.id)

    @achievement_state = if @achievements.in_state(:complete).any?
      :complete
    elsif @achievements.in_state(:enrolled).any?
      :in_progress
    else
      :not_started
    end
  end
end
