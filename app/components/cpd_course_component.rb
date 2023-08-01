class CpdCourseComponent < ViewComponent::Base
  attr_reader :programme_activity, :current_user, :course, :last_margin, :achievement

  delegate :activity_icon_class,
           :activity_type,
           to: :helpers

  def initialize(programme_activity:, current_user:, last_margin: true)
    @programme_activity = programme_activity
    @current_user = current_user
    @last_margin = last_margin

    @course = Achiever::Course::Template.maybe_find_by_activity_code(programme_activity.stem_activity_code)
    @achievement = current_user.achievements.find_by_activity_id(programme_activity.activity_id)
  end
end
