class NonCommunityActivityGroupingComponent < ViewComponent::Base
  attr_reader :programme_activity_grouping, :user_completed, :programme, :recommended_activities, :pathway

  delegate :current_user, to: :helpers

  def initialize(programme_activity_grouping)
    @programme_activity_grouping = programme_activity_grouping
    @programme = programme_activity_grouping.programme
  end

  def before_render
    @pathway = current_user.user_programme_enrolments.find_by(programme:).pathway

    @recommended_activities = pathway.activities.joins(:programme_activities).where(programme_activities: { programme_activity_grouping: }) if pathway

    @user_completed = programme_activity_grouping.user_complete?(current_user)

    @issued_badge = Credly::Badge.by_programme_badge_template_ids(current_user.id, programme.badges.pluck(:credly_badge_template_id)) if programme.badges.any?
  end
end
