# frozen_string_literal: true

class Cms::TestimonialRowComponent < ViewComponent::Base
  def initialize(title:, testimonials:, background_color:)
    @title = title
    @testimonials = testimonials
    @background_color = background_color
  end

  def wrapper_classes
    classes = ["cms-testimonial-row"]
    classes << "#{@background_color}-bg" if @background_color
    classes
  end
end
