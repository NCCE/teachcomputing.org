require_relative('../lib/achiever')

class CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :create_achiever, only: [:index]

  def index
    @face_to_face_courses = @achiever.approvedCourseTemplates
    @face_to_face_course_occurrences = @achiever.fetchFutureCourses
    @online_courses = FutureLearn.new

    render :index
  end

  private

  def create_achiever
    @achiever = Achiever.new
  end
end
