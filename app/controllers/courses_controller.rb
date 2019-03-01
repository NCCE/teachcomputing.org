require_relative('../lib/achiever')

class CoursesController < ApplicationController
  before_action :create_achiever, only: [:index]

  def index
    @courses = @achiever.approved_course_templates
    course_occurrences = @achiever.future_courses

    @courses.each do |course|
      @achiever.course_template_subject_details(course)
      @achiever.course_template_age_range(course)
      course_occurrences.each do |course_occurrence|
        if course_occurrence.course_template_no == course.course_template_no
          course.occurrences.push(course_occurrence)
        end
      end
    end
    render :index
  end

  private

  def create_achiever
    @achiever = Achiever.new
  end
end
