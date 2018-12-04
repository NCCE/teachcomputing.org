require_relative('../lib/achiever')
require_relative('../lib/course_occurrence')

class CoursesController < ApplicationController
  def initialize
    @achiever = Achiever.new
    super()
  end

  def courses
    @courses = @achiever.fetchFutureCourses

    render template: "pages/#{params[:page_slug]}"
  end

  def course
    @course = CourseOccurrence.new(params[:id])
    render template: "pages/dashboard/course"
  end
end
