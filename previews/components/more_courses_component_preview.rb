class MoreCoursesComponentPreview < ViewComponent::Preview
  def no_courses
    course_filter = Achiever::CourseFilter.new(filter_params: {location: "Manchester"})
    render(MoreCoursesComponent.new(course_filter: course_filter, preview: true))
  end
end
