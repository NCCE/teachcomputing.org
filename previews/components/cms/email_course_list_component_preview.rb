# frozen_string_literal: true

class Cms::EmailCourseListComponentPreview < ViewComponent::Preview
  def default
    courses = Cms::Mocks::EmailComponents::CourseList.as_model
    render(Cms::EmailCourseListComponent.new(courses: courses.courses, section_title: "user"))
  end
end
