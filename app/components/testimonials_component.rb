# frozen_string_literal: true

class TestimonialsComponent < ViewComponent::Base
  def initialize(testimonials:, event_tracking_category:, testimonials_per_row:, light: false)
    @testimonials = testimonials
    @event_tracking_category = event_tracking_category
    @testimonials_per_row = testimonials_per_row
    @light = light
  end

  def background_class
    @light ? "testimonial--light" : "testimonial--dark"
  end

  def custom_properties
    "--testimonials-per-row: #{@testimonials_per_row};"
  end
end
