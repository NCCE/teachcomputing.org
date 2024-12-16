# frozen_string_literal: true

class PrimaryDashboardProgrammeCommunityActivityGroupComponent < CmsWithAsidesComponent
  delegate :current_user, to: :helpers

  def initialize(programme_activity_group:, current_user:)
    aside_sections = if programme_activity_group.web_copy_aside_slug.nil?
      nil
    else
      [{slug: programme_activity_group.web_copy_aside_slug}]
    end

    super(aside_sections:)
    @programme_activity_group = programme_activity_group
  end

  def before_render
    @current_user = current_user
  end

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

  def complete?
    completed_activities.size >= @programme_activity_group.required_for_completion
  end
end
