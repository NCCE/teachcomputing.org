class CareersVideoCardComponentPreview < ViewComponent::Preview
  def default
    params = {
      video_url: "https://www.youtube.com/watch?v=t0ojrm0fMoE&list=PLwcV67XMdDdJn_6BFs2h1yBeyZDArab7J&index=3",
      title: "Test Card",
      name: "Joe Blogs",
      job_title: "Manager",
      description: "Description on the the card about the contents."
    }

    render(CareersVideoCardComponent.new(**params))
  end
end
