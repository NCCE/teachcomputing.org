class CpdCourseComponent < ViewComponent::Base
  attr_reader :activity, :current_user, :course, :last_margin, :achievement

  delegate :activity_icon_class,
    :activity_type,
    to: :helpers

  def initialize(activity:, current_user:, last_margin: true)
    @current_user = current_user
    @last_margin = last_margin

    if activity.replaced_by
      begin
        @activity = activity
        # This is a replaced course, is it in Achiever?
        @course = Achiever::Course::Template.find_by_activity_code(@activity.stem_activity_code)
      rescue ActiveRecord::RecordNotFound
        # Not in achiever, means we need to load replace by
        @activity = activity.replaced_by
        # Try and get this one in achiever
        @course = Achiever::Course::Template.maybe_find_by_activity_code(@activity.stem_activity_code)
      end
    else
      # Course is not replaced by, use original logic
      @activity = activity
      @course = Achiever::Course::Template.maybe_find_by_activity_code(@activity.stem_activity_code) if @activity.stem_activity_code.present?
    end

    @achievement = current_user.achievements.to_a.find { _1.activity_id == @activity.id }
  end
end
