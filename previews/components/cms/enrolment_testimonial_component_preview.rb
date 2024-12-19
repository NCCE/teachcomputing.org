# frozen_string_literal: true

class Cms::EnrolmentTestimonialComponentPreview < ViewComponent::Preview
  def default
    render(Cms::EnrolmentTestimonialComponent.new(testimonial: "testimonial", enrolled_aside_slug: "enrolled_aside_slug", programme_slug: "programme_slug"))
  end
end
