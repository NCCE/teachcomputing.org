class Cms::TextWithTestimonialComponentPreview < ViewComponent::Preview
  def right_side
    render Cms::TextWithTestimonialComponent.new(
      text_content: Cms::Mocks::RichBlocks.as_model,
      buttons: [],
      testimonial: Cms::Mocks::Testimonial.as_model,
      testimonial_side: "right",
      background_color: nil
    )
  end

  def left_side
    render Cms::TextWithTestimonialComponent.new(
      text_content: Cms::Mocks::RichBlocks.as_model,
      buttons: [],
      testimonial: Cms::Mocks::Testimonial.as_model,
      testimonial_side: "left",
      background_color: nil
    )
  end

  def left_side_with_button
    render Cms::TextWithTestimonialComponent.new(
      text_content: Cms::Mocks::RichBlocks.as_model,
      buttons: [Cms::Mocks::DynamicComponents::Buttons::NcceButton.as_model],
      testimonial: Cms::Mocks::Testimonial.as_model,
      testimonial_side: "left",
      background_color: nil
    )
  end
end
