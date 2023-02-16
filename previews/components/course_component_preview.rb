# frozen_string_literal: true

class CourseComponentPreview < ViewComponent::Preview
  def default
    course = FactoryBot.build(:achiever_course_template)
    render CourseComponent.new(course:, filter: nil)
  end

  def with_occurrences
    course = FactoryBot.build(:achiever_course_template)
    course.occurrences = FactoryBot.build_list(:achiever_course_occurrence, 2)

    render CourseComponent.new(course:, filter: nil)
  end
end
