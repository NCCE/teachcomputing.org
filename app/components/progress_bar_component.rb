class ProgressBarComponent < ViewComponent::Base
    PROG_TITLE_TO_GROUPINGS = {
      "Teach primary computing" => [
        "Contribute to an online discussion",
        "Develop your teaching practice",
        "Develop computing in your community"
      ],
      "Teach secondary computing" => [
        "Develop your subject knowledge",
        "Develop your teaching practice",
        "Develop computing in your community"
      ]
    }.freeze
  
    def initialize(current_user, programme)
      @programme = programme
      @class_names = {}
  
      groupings = PROG_TITLE_TO_GROUPINGS[programme.title]
  
      groupings.each_with_index do |grouping_title, index|
        activity_grouping = programme.programme_activity_groupings.find_by(title: grouping_title)
        @class_names["class_name_#{index + 1}"] = activity_grouping&.user_complete?(current_user) ? "icon-ticked-circle" : "icon-blank-circle"
      end
    end
  end