# frozen_string_literal: true

class TestimonialComponent < ViewComponent::Base
  def initialize(name:, text:, image:, bio: nil, link_target: nil, event_category: nil, tracking_event: nil)
    @name = name
    @text = text
    @bio = bio
    @image = image
    @link_target = link_target
    @event_category = event_category
    @event_label = tracking_event
  end
end
