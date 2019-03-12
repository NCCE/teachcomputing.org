require_relative('../lib/achiever')

class CoursesController < ApplicationController
  layout 'full-width'
  before_action :create_achiever, only: [:index]
  before_action :init_filters, only: [:index]

  def index
    @courses = fetch_course_list

    @locations = course_locations(@course_occurrences)
    @levels = course_levels(@courses)
    @topics = course_tags(@courses)
    @courses = filter_courses(@courses)

    render :index
  end

  private

  def init_filters
    @current_location = nil
    @current_level = nil
    @current_topic = nil
    @course_occurrences = nil
  end

  def create_achiever
    @achiever = Achiever.new
  end

  def fetch_course_list
    courses = @achiever.approved_course_templates
    @course_occurrences = @achiever.future_face_to_face_courses + @achiever.future_online_courses

    courses.each do |course|
      @achiever.course_template_subject_details(course)
      @achiever.course_template_age_range(course)
      @course_occurrences.each do |course_occurrence|
        if course_occurrence.course_template_no == course.course_template_no
          course.occurrences.push(course_occurrence)
        end
      end
    end
    courses
  end

  def filter_courses(courses)
    courses.select do |c|
      has_level = true
      has_location = true
      has_topic = true

      if params[:level].present?
        @current_level = params[:level]
        has_level = c.key_stages.any?(@current_level)
      end
      if params[:location].present?
        @current_location = params[:location]
        has_location = c.occurrences.any? { |oc| oc.address_town == @current_location }
      end
      if params[:topic].present?
        @current_topic = params[:topic]
        has_topic = c.subjects.any?(@current_topic)
      end
      has_level && has_location && has_topic
    end
  end

  def course_tags(courses)
    courses.reduce([]) { |tags, c| tags + c.subjects }.uniq.sort
  end

  def course_levels(courses)
    courses.reduce([]) { |levels, c| levels + c.key_stages }.uniq.sort
  end

  def course_locations(course_occurrences)
    towns = course_occurrences.reduce([]) { |acc, oc| oc.online_course == 0 ? acc.push(oc.address_town) : acc }
    towns.uniq.sort.unshift('Online')
  end
end
