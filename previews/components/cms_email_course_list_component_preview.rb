# frozen_string_literal: true

class CmsEmailCourseListComponentPreview < ViewComponent::Preview
  def default
    render(Cms::EmailCourseListComponent.new(course_list: "course_list", user: "user"))
  end
end
