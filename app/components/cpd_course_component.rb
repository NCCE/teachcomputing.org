class CpdCourseComponent < ViewComponent::Base
  attr_reader :activity, :current_user, :course, :last_margin, :achievement

  delegate :activity_icon_class,
           :activity_type,
           to: :helpers

  def initialize(activity:, current_user:, last_margin: true)
    @activity = activity
    @current_user = current_user
    @last_margin = last_margin

    @course = Achiever::Course::Template.maybe_find_by_activity_code(activity.stem_activity_code) if activity.stem_activity_code.present?
    @achievement = current_user.achievements.find_by(activity_id: @activity.id)
  end
end
