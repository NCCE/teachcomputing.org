require_relative('../lib/achiever')

class CoursesController < ApplicationController
  def courses
    achiever = Achiever.new
    @courses = achiever.fetchFutureCourses

    render template: "pages/#{params[:page_slug]}"
  end
end
