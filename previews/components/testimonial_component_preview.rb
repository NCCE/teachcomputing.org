class TestimonialComponentPreview < ViewComponent::Preview
  def default
    render(
      TestimonialComponent.new(
        name: "Mike Squance",
        text: "Teach computing in the best website to learn how to teach computing",
        bio: "Senior Ruby Developer",
        image: "media/images/test/image.png"
      )
    )
  end

  def with_link
    render(
      TestimonialComponent.new(
        name: "Mike Squance",
        text: "Teach computing in the best website to learn how to teach computing",
        bio: "Senior Ruby Developer",
        image: "media/images/test/image.png",
        link_target: "http://www.teachcomputing.org"
      )
    )
  end
end
