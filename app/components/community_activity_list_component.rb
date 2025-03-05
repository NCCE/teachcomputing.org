class CommunityActivityListComponent < ViewComponent::Base
  attr_reader :first_activities, :second_activities, :tracking_category

  def initialize(programme_activity_grouping:, community_achievements:, number_to_show: 4, class_name: nil, button_class: nil)
    @number_to_show = number_to_show
    @class_name = class_name
    @button_class = button_class

    activities_with_achievements = programme_activity_grouping.programme_activities.map do |programme_activity|
      {
        programme_activity:,
        achievement: community_achievements&.find { _1.activity_id == programme_activity.activity_id }
      }
    end

    # Remove legacy only if they have an achievement
    activities_with_achievements.delete_if { _1[:achievement].nil? && _1[:programme_activity].legacy }

    complete, non_complete = activities_with_achievements.partition { _1[:achievement]&.in_state? :complete }

    if complete.size < programme_activity_grouping.required_for_completion
      sorted_activities = complete + non_complete
      @first_activities = sorted_activities.first(@number_to_show)
      @second_activities = sorted_activities[@number_to_show..]
    else
      @first_activities = complete
      @second_activities = non_complete
    end
  end
end
