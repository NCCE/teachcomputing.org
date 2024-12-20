# frozen_string_literal: true

class CommunityActivityComponent < ViewComponent::Base
  def initialize(activity:, achievement: nil, class_name: nil, button_class: nil)
    @activity = activity
    @achievement = achievement
    @class_name = class_name
    @button_class = button_class
  end
end
