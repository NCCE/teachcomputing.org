require_relative('../lib/achiever')

class CoursesController < ApplicationController
  before_action :create_achiever, only: [:index]

  def index
    @courses = @achiever.approved_course_templates
    course_occurrences = @achiever.future_courses
    course_occurrence_hash = {}
    course_occurrences.each do |course_occurrence|
      if course_occurrence_hash[course_occurrence.course_template_no].nil?
        course_occurrence_hash[course_occurrence.course_template_no] = []
      end
      course_occurrence_hash[course_occurrence.course_template_no].push(course_occurrence)
    end
    @courses.each do |course|
      course.course_occurrences = course_occurrence_hash[course.course_template_no] || []
    end
    render :index
  end

  private

  def create_achiever
    @achiever = Achiever.new
  end
end
