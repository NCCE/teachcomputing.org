# frozen_string_literal: true

class PrimaryDashboardCommunityActivityComponent < Cms::WithAsidesComponent
  delegate :current_user, to: :helpers

  def initialize(programme_activity_group:)
    @programme_activity_group = programme_activity_group
    @programme_activities = @programme_activity_group.programme_activities.not_legacy.includes(:activity)
  end

  def before_render
    @current_user = current_user
  end

  private

  def completed_activities
    @current_user.achievements
      .in_state(:complete)
      .belonging_to_programme_activity_grouping(@programme_activity_group)
      .includes([:activity])
  end

  def incomplete_activities
    @current_user.achievements
      .not_in_state(:complete)
      .belonging_to_programme_activity_grouping(@programme_activity_group)
      .includes([:activity])
  end

  def available_activities
    @available_activities ||= @programme_activities.reject do |pa|
      chosen_activity_ids.include?(pa.activity.id)
    end
  end

  def chosen_activity_ids
    (completed_activities + incomplete_activities)
      .map(&:activity_id)
  end
end
