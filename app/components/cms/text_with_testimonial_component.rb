# frozen_string_literal: true

class Cms::TextWithTestimonialComponent < ViewComponent::Base
  def initialize(text_content:, buttons:, testimonial_side:, testimonial:, background_color:)
    @text_content = text_content
    @buttons = buttons
    @testimonial_side = testimonial_side
    @testimonial = testimonial
    @background_color = background_color
  end

  def row_classes
    classes = ["tc-row"]
    classes << "testimonial-#{@testimonial_side}"
    classes
  end

end
