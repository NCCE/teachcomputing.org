# frozen_string_literal: true

class Cms::EnrolmentTestimonialComponentPreview < ViewComponent::Preview
  def default
    render(Cms::EnrolmentTestimonialComponent.new(
      title: "Testimonial Title",
      testimonial: Cms::Mocks::DynamicComponents::ContentBlocks::Testimonial.as_model,
      enrol_aside: [{slug: "i-belong-dashboard-resources"}],
      enrolled_aside: [],
      programme_slug: "primary-certificate",
      background_color: Cms::Mocks::Meta::ColorScheme.generate_data(name: "standard")
    ))
  end
end
