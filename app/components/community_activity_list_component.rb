class CommunityActivityListComponent < ViewComponent::Base
  attr_reader :first_activities, :second_activities, :tracking_category

  def initialize(programme_activity_grouping:, community_achievements:, number_to_show: 4, button_class: nil, class_name: nil)
    @number_to_show = number_to_show
    @button_class = button_class
    @class_name = class_name
    activities_with_achievements = programme_activity_grouping.programme_activities.not_legacy.map do |programme_activity|
      {
        programme_activity:,
        achievement: community_achievements&.find { _1.activity_id == programme_activity.activity_id }
      }
    end

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
