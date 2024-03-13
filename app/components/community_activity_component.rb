# frozen_string_literal: true

class CommunityActivityComponent < ViewComponent::Base
  include ViewComponent::Translatable

  def initialize(activity:, achievement: nil, class_name: nil, tracking_category: nil)
    @activity = activity
    @achievement = achievement
    @class_name = class_name
    @tracking_category = tracking_category
  end

  def achievement_complete?
    return unless @achievement

    @achievement.in_state? :complete
  end

  def achievement_rejected?
    return unless @achievement

    @achievement.in_state? :rejected
  end

  def reopen_button_text
    return "Add more evidence" if achievement_rejected?
    @achievement&.evidence.present? ? "Continue editing" : "Submit evidence"
  end

  def tracking_data(label)
    return nil unless @tracking_category.present? && label.present?

    {
      event_action: "click",
      event_category: @tracking_category,
      event_label: label
    }
  end
end
