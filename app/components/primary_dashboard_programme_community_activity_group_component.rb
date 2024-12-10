# frozen_string_literal: true

class PrimaryDashboardProgrammeCommunityActivityGroupComponent < CmsWithAsidesComponent
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
  end

  def before_render
    @current_user = current_user
  end

  def user_programme_activities
    {
      complete: @current_user.achievements.in_state(:complete).belonging_to_programme_activity_grouping(@programme_activity_group).includes([:activity]),
      incomplete: @current_user.achievements.not_in_state(:complete).belonging_to_programme_activity_grouping(@programme_activity_group).includes([:activity])
    }
  end

  def complete?
    user_programme_activities[:complete].size >= @programme_activity_group.required_for_completion
  end
end
