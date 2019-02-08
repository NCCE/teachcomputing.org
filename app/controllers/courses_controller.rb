require_relative('../lib/achiever')

class CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :create_achiever, only: [:index]

  def index
    @courses = @achiever.approved_course_templates
    @course_occurrences = @achiever.future_courses

    render :index
  end

  private

  def create_achiever
    @achiever = Achiever.new
  end
end
