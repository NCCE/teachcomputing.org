class CoursesController < ApplicationController
  layout 'full-width'
  before_action :init_filters, only: [:index]

  def index
    @subjects = Achiever::Course::Subject.all
    @age_groups = Achiever::Course::AgeGroup.all
    @courses = Achiever::Course::Template.all
    @course_occurrences = Achiever::Course::Occurrence.face_to_face + Achiever::Course::Occurrence.online

    @courses.each do |course|
      @course_occurrences.each do |course_occurrence|
        if course_occurrence.course_template_no == course.course_template_no
          course.occurrences.push(course_occurrence)
        end
      end
    end

    @locations = course_locations(@course_occurrences)
    @levels = @age_groups
    @topics = course_tags(@courses)
    @workstreams = 'CS Accelerator'
    @courses = filter_courses(@courses)

    alert_filter_params

    render :index
  end

  private

    def init_filters
      @current_location = nil
      @current_level = nil
      @current_topic = nil
      @current_workstream = nil
      @course_occurrences = nil
    end

    def filter_courses(courses)
      courses.select do |c|
        has_level = true
        has_location = true
        has_topic = true
        has_workstream = true

        if params[:level].present?
          @current_level = params[:level]
          key = @age_groups[params[:level]].to_s
          has_level = c.age_groups.any?(key)
        end
        if params[:location].present?
          @current_location = params[:location]
          has_location = compare_location(c, @current_location)
        end
        if params[:topic].present?
          @current_topic = params[:topic]
          key = @subjects[params[:topic]].to_s
          has_topic = c.subjects.any?(key)
        end
        if params[:workstream].present?
          @current_workstream = params[:workstream]
          has_workstream = c.workstream == @current_workstream
        end
        has_level && has_location && has_topic && has_workstream
      end
    end

    def alert_filter_params
      filter_strings = []
      filter_strings.push("<strong>Level</strong>: #{@current_level}") if @current_level
      filter_strings.push("<strong>Topic</strong>: #{@current_topic}") if @current_topic
      filter_strings.push("<strong>Location</strong>: #{@current_location}") if @current_location
      filter_strings.push("<strong>Programme</strong>: #{@current_workstream}") if @current_workstream

      return if filter_strings.empty?

      notice = "<span>You are filtering with #{filter_strings.join('; ')}</span>"
      notice += " #{view_context.link_to('Remove filter', url_for(controller: 'courses', anchor: 'filter-results'))}"
      flash.now[:notice] = notice
    end

    def compare_location(course, location)
      case location
      when 'Online'
        course.online_cpd
      when 'Face to face'
        !course.online_cpd
      else
        course.occurrences.any? { |oc| oc.address_town == location }
      end
    end

    def course_tags(courses)
      used_subjects = courses.reduce([]) { |tags, c| tags + c.subjects }.uniq.sort
      @subjects.select { |_k, v| used_subjects.include?(v.to_s) }
    end

    def course_locations(course_occurrences)
      towns = course_occurrences.reduce([]) { |acc, oc| !oc.online_cpd ? acc.push(oc.address_town) : acc }
      towns.uniq.sort.unshift('Face to face').unshift('Online')
    end
end
