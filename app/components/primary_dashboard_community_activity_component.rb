# frozen_string_literal: true

class PrimaryDashboardCommunityActivityComponent < CmsWithAsidesComponent
  delegate :current_user, to: :helpers

  def initialize(programme_activity_group:, user_programme_activities:)
    @programme_activity_group = programme_activity_group
    @user_programme_activities = user_programme_activities

    @programme_activities = @programme_activity_group.programme_activities.not_legacy.includes(:activity)
  end

  def before_render
    @current_user = current_user
  end

  private

  def available_activities
    @available_activities ||= @programme_activities.reject do |pa|
      chosen_activity_ids.include?(pa.activity.id)
    end
  end

  def chosen_activity_ids
    (@user_programme_activities[:incomplete] + @user_programme_activities[:complete])
      .map(&:activity_id)
  end
end
