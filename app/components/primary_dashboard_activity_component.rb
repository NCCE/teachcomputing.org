# frozen_string_literal: true

class PrimaryDashboardActivityComponent < CmsWithAsidesComponent
  def initialize(programme_activities:, current_user:, programme_activity_group:)
    @programme_activities = programme_activities
    @current_user = current_user
    @programme_activity_group = programme_activity_group
  end

  def user_programme_activities
    user_achievements = @current_user.achievements

    complete_activity_ids = user_achievements.select { |a| a.complete? }.map(&:activity_id)
    incomplete_activity_ids = user_achievements.select { |a| !a.complete? }.map(&:activity_id)

    {
      complete: @programme_activities
        .where(activity_id: complete_activity_ids)
        .includes(:activity),
      incomplete: @programme_activities
        .where(activity_id: incomplete_activity_ids)
        .includes(:activity)
    }
  end

  def heading_text
    user_programme_activities.present? ? "Complete your chosen activity" : "Complete at least one activity"
  end
end
