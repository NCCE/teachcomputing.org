# frozen_string_literal: true

class PrimaryDashboardActivityComponent < CmsWithAsidesComponent
  def initialize(programme_activities:, current_user:)
    @programme_activities = programme_activities
    @current_user = current_user
  end

  def user_programme_activities
    user_activity_ids = @current_user.achievements.pluck(:activity_id)

    @programme_activities
      .where(activity_id: user_activity_ids)
      .includes(:activity)
  end

  def heading_text
    user_programme_activities.present? ? "Complete your chosen activity" : "Complete at least one activity"
  end
end
