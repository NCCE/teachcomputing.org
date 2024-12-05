# frozen_string_literal: true

class PrimaryDashboardProgrammeActivityGroupComponent < CmsWithAsidesComponent
  delegate :current_user, to: :helpers

  def initialize(title:, programme_activity_group:, current_user:, aside_slug: nil)
    aside_sections = if aside_slug.nil?
      nil
    else
      [{slug: aside_slug}]
    end

    super(aside_sections:)
    @title = title
    @programme_activity_group = programme_activity_group

    @programme_activities = @programme_activity_group.programme_activities.not_legacy do |programme_activity|
      Activity.find(programme_activity.activity_id)
    end
  end

  def before_render
    @current_user = current_user
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

  def complete?
    user_programme_activities[:complete].size >= @programme_activity_group.required_for_completion
  end
end
