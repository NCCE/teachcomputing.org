# frozen_string_literal: true

class Cms::TestimonialRowComponentPreview < ViewComponent::Preview
  def default
    testimonial_row = Cms::Mocks::TestimonialRow.as_model
    render(testimonial_row.render)
  end
end
