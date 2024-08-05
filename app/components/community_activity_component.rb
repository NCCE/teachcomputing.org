# frozen_string_literal: true

class CommunityActivityComponent < ViewComponent::Base
  include ViewComponent::Translatable

  def initialize(activity:, achievement: nil, class_name: nil, button_class: nil)
    @activity = activity
    @achievement = achievement
    @class_name = class_name
    @button_class = button_class
  end

  def achievement_complete?
    return unless @achievement

    @achievement.in_state?(:complete) && @achievement.submission_option.blank?
  end

  def achievement_rejected?
    return unless @achievement

    @achievement.in_state? :rejected
  end

  def reopen_button_text
    return "Add more evidence" if achievement_rejected?
    @achievement&.evidence.present? ? "Continue editing" : "Submit evidence"
  end
end
