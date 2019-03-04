require_relative('../lib/achiever')

class CoursesController < ApplicationController
  before_action :create_achiever, only: [:index]

  def index
    @courses = @achiever.approved_course_templates
    course_occurrences = @achiever.future_courses
    @locations = {}
    @courses.each do |course|
      course_occurrences.each do |course_occurrence|
        if course_occurrence.course_template_no == course.course_template_no
          course.occurrences.push(course_occurrence)
          if course_occurrence.online_course == 1
            @locations['Online'] = true
          elsif !course_occurrence.address_town.empty?
            @locations[course_occurrence.address_town] = true
          end
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
