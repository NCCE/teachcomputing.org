class CommunityActivityListComponent < ViewComponent::Base
  attr_reader :first_activities, :second_activities, :tracking_category

  def initialize(programme_activities:, community_achievements:, tracking_category:)
    activities_with_achievements = programme_activities.map do |programme_activity|
      {
        programme_activity:,
        achievement: community_achievements&.find { _1.activity_id == programme_activity.activity_id }
      }
    end

    complete, non_complete = activities_with_achievements.partition { _1[:achievement]&.in_state? :complete }

    if complete.empty?
      @first_activities = non_complete.first(4)
      @second_activities = non_complete[4..]
    else
      @first_activities = complete
      @second_activities = non_complete
    end

    @tracking_category = tracking_category
  end
end
