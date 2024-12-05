# frozen_string_literal: true

class PrimaryDashboardActivityComponent < CmsWithAsidesComponent
  delegate :current_user, to: :helpers

  def initialize(programme_activities:, programme_activity_group:, user_programme_activities:)
    @programme_activities = programme_activities
    @programme_activity_group = programme_activity_group
    @user_programme_activities = user_programme_activities
  end

  def before_render
    @current_user = current_user
  end

  def heading_text
    user_programme_activities.present? ? "Complete your chosen activity" : "Complete at least one activity"
  end
end
