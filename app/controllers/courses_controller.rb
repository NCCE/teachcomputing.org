require_relative('../lib/achiever')
require_relative('../lib/course_occurrence')

class CoursesController < ApplicationController
  before_action :create_achiever, only: [:index]

  def index
    @face_to_face_courses = @achiever.fetchFutureCourses
    @online_courses = FutureLearn.new

    render :index
  end

  def show
    @course = CourseOccurrence.new(params[:id])
    render :show
  end

  private

  def create_achiever
    @achiever = Achiever.new
  end
end