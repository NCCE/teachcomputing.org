# frozen_string_literal: true

class CommunityActivityComponent < ViewComponent::Base
  def initialize(activity:, achievement: nil, class_name: nil, button_class: nil)
    @activity = activity
    @achievement = achievement
    @class_name = class_name
    @button_class = button_class
  end

  def achievement_complete?
    return unless @achievement

    return false if @activity.public_copy_submission_options
    @achievement.in_state?(:complete)
  end

  def achievement_rejected?
    return unless @achievement

    @achievement.in_state? :rejected
  end
end
