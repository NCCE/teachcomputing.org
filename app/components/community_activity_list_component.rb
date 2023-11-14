class CommunityActivityListComponent < ViewComponent::Base
  attr_reader :first_activities, :second_activities, :tracking_category

  def initialize(programme_activity_grouping:, community_achievements:, tracking_category:)
    activities_with_achievements = programme_activity_grouping.programme_activities.not_legacy.map do |programme_activity|
      {
        programme_activity:,
        achievement: community_achievements&.find { _1.activity_id == programme_activity.activity_id }
      }
    end

    complete, non_complete = activities_with_achievements.partition { _1[:achievement]&.in_state? :complete }

    if complete.size < programme_activity_grouping.required_for_completion
      sorted_activities = complete + non_complete
      @first_activities = sorted_activities.first(4)
      @second_activities = sorted_activities[4..]
    else
      @first_activities = complete
      @second_activities = non_complete
    end

    @tracking_category = tracking_category
  end
end
