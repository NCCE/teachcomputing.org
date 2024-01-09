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

  def online_always_on_with_occurrences
    course = FactoryBot.build(:achiever_course_template, online_cpd: true, always_on: true)
    course.occurrences = FactoryBot.build_list(:achiever_course_occurrence, 2)

    render CourseComponent.new(course:, filter: nil)
  end

  def online_not_always_on_with_occurrences
    course = FactoryBot.build(
      :achiever_course_template,
      online_cpd: true,
      always_on: false,
      title: "This should not happen as online courses should always be on"
    )
    course.occurrences = FactoryBot.build_list(:achiever_course_occurrence, 2)

    render CourseComponent.new(course:, filter: nil)
  end
end
