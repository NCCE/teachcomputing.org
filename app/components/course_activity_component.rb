# frozen_string_literal: true

class CourseActivityComponent < ViewComponent::Base
  include ViewComponent::Translatable

  delegate :activity_icon_class,
    :activity_type,
    to: :helpers

  def initialize(objective:, booking:, achievements: nil, class_name: nil, tracking_category: nil)
    @objective = objective
    @booking = booking
    @achievements = achievements
    @class_name = class_name
    @tracking_category = tracking_category
  end

  def achievements_complete?
    return unless @achievements

    @achievements.any? { |ach| ach.in_state? :complete }
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
