class TestimonialsComponentPreview < ViewComponent::Preview
  include ActionView::Helpers::UrlHelper
  include CareersHelper

  def two_per_row_one_row
    render(TestimonialsComponent.new(
      testimonials: careers_support_testimonal_data,
      testimonials_per_row: 2,
      event_tracking_category: ""
    ))
  end

  def three_per_row_one_row
    render(TestimonialsComponent.new(
      testimonials: careers_support_testimonal_data.concat(Array.wrap(careers_support_testimonal_data[0])),
      testimonials_per_row: 3,
      event_tracking_category: ""
    ))
  end

  def two_per_row_multi_row
    render(TestimonialsComponent.new(
      testimonials: careers_support_testimonal_data.zip(careers_support_testimonal_data).flatten,
      testimonials_per_row: 2,
      event_tracking_category: ""
    ))
  end

  def three_per_row_multi_row
    render(TestimonialsComponent.new(
      testimonials: careers_support_testimonal_data.zip(careers_support_testimonal_data).flatten,
      testimonials_per_row: 3,
      event_tracking_category: ""
    ))
  end
end
