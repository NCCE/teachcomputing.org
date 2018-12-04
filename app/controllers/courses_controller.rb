require_relative('../lib/achiever')
require_relative('../lib/course_occurrence')

class CoursesController < ApplicationController
<<<<<<< HEAD
  def initialize
    @achiever = Achiever.new
    super()
  end
  def index
    achiever = Achiever.new
    @face_to_face_courses = achiever.fetchFutureCourses
    @online_courses = FutureLearn.new

    render :index
  end

  def show
    @course = CourseOccurrence.new(params[:id])
    render :show
  end
end
