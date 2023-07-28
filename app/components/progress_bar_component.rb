class ProgressBarComponent < ViewComponent::Base
    def initialize(current_user, programme)
      @programme = programme
      @class_names = {}
      index = 0
  
      grouping_titles = programme.programme_activity_groupings.map(&:title).drop(1)
  
      grouping_titles.each do |title|
        index += 1
        activity_grouping = programme.programme_activity_groupings.find_by_title(title)
        @class_names["class_name_#{index}"] = activity_grouping&.user_complete?(current_user) ? "icon-ticked-circle" : "icon-blank-circle"
      end
    end
  end