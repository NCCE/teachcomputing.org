class CurriculumVideoComponentPreview < ViewComponent::Preview
  def column_layout_for_lesson_page
    params = {
      name: "John Teacher",
      job_title: "Head of IT",
      description: "Description of the video contents.",
      video_url: "https://www.youtube.com/watch?v=t0ojrm0fMoE&list=PLwcV67XMdDdJn_6BFs2h1yBeyZDArab7J&index=3",
      layout: :col
    }

    render(CurriculumVideoComponent.new(**params))
  end

  def row_layout_for_unit_page
    params = {
      name: "John Teacher",
      job_title: "Head of IT",
      description: "Description of the video contents.",
      video_url: "https://www.youtube.com/watch?v=t0ojrm0fMoE&list=PLwcV67XMdDdJn_6BFs2h1yBeyZDArab7J&index=3",
      layout: :row
    }

    render(CurriculumVideoComponent.new(**params))
  end
end
