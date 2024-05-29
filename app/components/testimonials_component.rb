# frozen_string_literal: true

class TestimonialsComponent < ViewComponent::Base
  def initialize(testimonials:, event_tracking_category:, testimonials_per_row:, wrap_text: false, light: false, show_all_on_mobile: false)
    @testimonials = testimonials
    @event_tracking_category = event_tracking_category
    @testimonials_per_row = testimonials_per_row
    @wrap_text = wrap_text
    @light = light
    @show_all_on_mobile = show_all_on_mobile
  end

  def background_class
    light_css = @light ? "testimonial--light" : "testimonial--dark"
    wrap_text_css = @wrap_text ? "testimonial--wrap-text" : ""
    show_all_on_mobile_css = @show_all_on_mobile ? "testimonial--show-all-on-mobile" : ""

    "#{light_css} #{wrap_text_css} #{show_all_on_mobile_css}".strip
  end

  def custom_properties
    "--testimonials-per-row: #{@testimonials_per_row};"
  end
end
