require_relative('../lib/achiever')

class CoursesController < ApplicationController
  def index
    achiever = Achiever.new
    @face_to_face_courses = achiever.fetchFutureCourses
    @online_courses = FutureLearn.new

    render :index
  end
end
