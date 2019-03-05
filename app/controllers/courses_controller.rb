require_relative('../lib/achiever')

class CoursesController < ApplicationController
  before_action :create_achiever, only: [:index]

  def index
    # location_filter = params[:location]

    @courses = @achiever.approved_course_templates
    @course_occurrences = @achiever.future_courses

    @courses.each do |course|
      @achiever.course_template_subject_details(course)
      @achiever.course_template_age_range(course)
      @course_occurrences.each do |course_occurrence|
        if course_occurrence.course_template_no == course.course_template_no
          course.occurrences.push(course_occurrence)
        end
      end
    end

    @locations = course_locations
    @levels = course_levels
    @topics = course_tags

    @current_location = params[:location] # xss?
    @current_level = params[:level] # xss?
    @current_topic = params[:topic] # xss?

    puts "locations #{@locations}, topics #{@topics}, levels #{@levels}"
    puts "location #{@current_location}, topic #{@current_topic}, level #{@current_level}"

    render :index
  end

  private

  def create_achiever
    @achiever = Achiever.new
  end

  def course_tags
    @courses.inject([]) { |tags, c| tags + c.subjects }.uniq
  end

  def course_levels
    @courses.inject([]) { |levels, c| levels + c.key_stages }.uniq
  end

  def course_locations
    @course_occurrences.map { |oc| oc.online_course == 1 ? 'Online' : oc.address_town }.uniq
  end
end
