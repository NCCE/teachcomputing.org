class CommunityActivityGroupingComponent < ViewComponent::Base
  delegate :current_user, to: :helpers

  attr_reader :programme_activity_grouping, :programme, :programme_activities, :community_achievements, :pathway, :user_completed

  def initialize(programme_activity_grouping)
    @programme_activity_grouping = programme_activity_grouping
    @programme = programme_activity_grouping.programme
  end

  def before_render
    @user_completed = programme_activity_grouping.user_complete?(current_user)

    @pathway = current_user.user_programme_enrolments.find_by(programme:).pathway
    @programme_activities = programme_activity_grouping.order_programme_activities_for_user(current_user, pathway)
    @community_achievements = current_user.achievements.joins(activity: :programme_activities).where(activity: { programme_activities: })
  end
end
