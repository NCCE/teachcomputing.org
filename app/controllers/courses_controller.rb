require_relative('../lib/achiever')

class CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :create_achiever, only: [:index]

  def index
    @courses = @achiever.approvedCourseTemplates
    @course_occurrences = @achiever.fetchFutureCourses

    render :index
  end

  private

  def create_achiever
    @achiever = Achiever.new
  end
end
