class ProgressBarComponent < ViewComponent::Base
    def initialize(current_user, programme)
      @programme = programme
      @current_user = current_user
      index = 0
  
      grouping_titles = programme.programme_activity_groupings.map(&:title).drop(1)
  
      grouping_titles.each do |title|
        index += 1
        activity_grouping = programme.programme_activity_groupings.find_by_title(title)
      end
    end
  end