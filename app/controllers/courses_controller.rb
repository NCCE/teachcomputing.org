require_relative('../lib/achiever')

class CoursesController < ApplicationController
  before_action :create_achiever, only: [:index]

  def index
    @face_to_face_courses = @achiever.approved_face_to_face_course_templates
    @online_courses = @achiever.approved_online_course_templates
    course_occurrences = @achiever.future_courses
    @courses = @face_to_face_courses + @online_courses
    @courses.each do |course|
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
