# frozen_string_literal: true

class Cms::CommunityActivityListComponent < ViewComponent::Base
  delegate :current_user, to: :helpers

  def initialize(title:, intro:, programme_activity_group_slug:)
    @title = title
    @intro = intro
    @programme_activity_group = ProgrammeActivityGrouping.includes(:programme).find_by(title: programme_activity_group_slug)
    @programme = @programme_activity_group.programme
  end

  def before_render
    @enrolled = @programme.user_enrolled?(current_user)
    if @enrolled
      @achievements = user_achievements
      @started_activities = @achievements.collect { _1.activity }
      @activities = @programme_activity_group.activities - @started_activities
    else
      @started_activities = []
      @activities = @programme_activity_group.activities
    end
  end

  def user_achievements
    Achievement.joins(activity: {programme_activities: :programme_activity_grouping}).where(
      "programme_activity_groupings.id": @programme_activity_group.id,
      user: current_user
    )
  end
end
