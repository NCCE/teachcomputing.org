# frozen_string_literal: true

class CmsEmailCourseListComponentPreview < ViewComponent::Preview
  def default
    render(CmsEmailCourseListComponent.new(course_list: "course_list", user: "user"))
  end
end
