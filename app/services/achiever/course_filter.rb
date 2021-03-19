module Achiever
  class CourseFilter
    attr_reader :subjects, :age_groups

    def initialize(filter_params:)
      @filter_params = filter_params

      # @filter_params[:search_location] = 'London'
      # puts @filter_params[:search_location]
      @subjects = Achiever::Course::Subject.all
      @age_groups = Achiever::Course::AgeGroup.all
    end

    def courses
      @courses ||= begin
        courses = all_courses

        courses.each do |course|
          course_occurrences.each do |course_occurrence|
            if course_occurrence.course_template_no == course.course_template_no
              course.occurrences.push(course_occurrence)
            end
          end
        end
        courses.reject! { |c| c.occurrences.count.zero? } if current_hub.present?

        filter_courses(courses)
        # sort_courses(filtered_courses)
      end
    end

    def course_locations
      towns = course_occurrences.reduce([]) do |acc, occurrence|
        occurrence.online_cpd ? acc : acc.push(occurrence.address_town)
      end
      towns.reject do |location|
        location.downcase.include?('remote delivered cpd')
      end.uniq.sort.unshift('Face to face', 'Online', 'Remote')
    end

    def course_tags
      used_subjects = all_courses.reduce([]) { |tags, c| tags + c.subjects }.uniq.sort
      @subjects.select { |_k, v| used_subjects.include?(v.to_s) }
    end

    def current_certificate
      return nil unless @filter_params[:certificate].present?

      @current_certificate ||= Programme.find_by(slug: @filter_params[:certificate])
    end

    def current_topic
      return nil unless @filter_params[:topic].present?

      @current_topic ||= @filter_params[:topic]
    end

    def current_location
      return nil unless @filter_params[:location].present?

      @current_location ||= @filter_params[:location]
    end

    def current_level
      return nil unless @filter_params[:level].present?

      @current_level ||= @filter_params[:level]
    end

    def current_hub
      return nil unless @filter_params[:hub_id].present?

      @current_hub ||= begin
        course_occurrences.map(&:hub_name).compact.first || 'Hub - no courses'
      end
    end

    def applied_filters
      filter_strings = []
      filter_strings.push(ERB::Util.html_escape(current_level).to_s) if current_level
      filter_strings.push(ERB::Util.html_escape(current_location).to_s) if current_location
      filter_strings.push(ERB::Util.html_escape(current_topic).to_s) if current_topic
      filter_strings.push(current_certificate.title.to_s) if current_certificate
      filter_strings.push(current_hub) if current_hub

      return if filter_strings.empty?

      filter_strings
    end

    def search_location_formatted_address
      return @search_location_formatted_address if defined? @search_location_formatted_address

      @search_location_formatted_address = if geocoded_search_location.nil?
                                             'This location was not recognised. Please check if it is correct.'
                                           else
                                             geocoded_search_location.formatted_address
                                           end
    end

    def location_search?
      @filter_params[:search_location].present?
    end

    def search_radius
      return @search_radius if defined? @search_radius

      @search_radius = if @filter_params[:radius].present?
                         @filter_params[:radius]
                       else
                         '40'
                       end
    end

    def location_search_results
      return nil unless location_search?
      return @location_search_results if defined? @location_search_results

      @location_search_results = begin
        f2f_courses = courses.select { |c| !c.online_cpd && !c.remote_delivered_cpd }

        f2f_courses.sort! do |a, b|
          a.nearest_occurrence_distance <=> b.nearest_occurrence_distance || (b.nearest_occurrence_distance && 1) || -1
        end
        f2f_courses.each do |course|
          course.occurrences.sort! do |a, b|
            a.distance <=> b.distance || (b.distance && 1) || -1
          end
        end
        radius = search_radius.to_i
        f2f_courses.select { |c| c.nearest_occurrence_distance.present? && c.nearest_occurrence_distance <= radius }
      end
    end

    def non_location_search_results
      return courses unless location_search?
      return @non_location_search_results if defined? @non_location_search_results

      @non_location_search_results = begin
        courses.select { |c| c&.online_cpd || c&.remote_delivered_cpd }
      end
    end

    private

      def all_courses
        @all_courses ||= Achiever::Course::Template.all
      end

      def course_occurrences
        @course_occurrences ||= begin
          course_occurrences = Achiever::Course::Occurrence
                               .face_to_face(
                                 search_location_coordinates: search_location_coordinates
                               ) +
                               Achiever::Course::Occurrence.online
          filter_course_occurences(course_occurrences)
        end
      end

      def filter_course_occurences(course_occurrences)
        return course_occurrences unless @filter_params[:hub_id].present?

        course_occurrences.select { |co| co.hub_id == @filter_params[:hub_id] }
      end

      def filter_courses(courses)
        courses.select do |c|
          has_certificate = true
          has_level = true
          has_location = true
          has_topic = true

          has_certificate = c.by_certificate(current_certificate.slug) if current_certificate

          has_level = c.age_groups.any?(current_level_age_group_key) if current_level

          has_location = compare_location(c, current_location) if current_location

          has_topic = c.subjects.any?(current_topic_subject_key) if current_topic

          has_certificate && has_level && has_location && has_topic
        end
      end

      def compare_location(course, location)
        case location
        when 'Online'
          course.online_cpd
        when 'Face to face'
          !course.online_cpd && !course.remote_delivered_cpd
        when 'Remote'
          course.remote_delivered_cpd
        else
          course.occurrences.any? { |oc| oc.address_town == location }
        end
      end

      def current_topic_subject_key
        @subjects[current_topic].to_s
      end

      def current_level_age_group_key
        @age_groups[current_level].to_s
      end

      def search_location_coordinates
        return nil unless location_search?
        return @search_location_coordinates if defined? @search_location_coordinates

        @search_location_coordinates = if geocoded_search_location.nil?
                                         nil
                                       else
                                         geocoded_search_location.coordinates
                                       end
      end

      def geocoded_search_location
        return @geocoded_search_location if defined? @geocoded_search_location

        @geocoded_search_location = Geocoder.search(@filter_params[:search_location], params: { region: 'GB' }).first
      end

      def sort_courses(courses)
        return courses unless location_search?

        f2f_courses = courses.select { |c| !c.online_cpd && !c.remote_delivered_cpd }
        other_courses = courses.difference(f2f_courses)

        f2f_courses.sort! do |a, b|
          a.nearest_occurrence_distance <=> b.nearest_occurrence_distance || (b.nearest_occurrence_distance && 1) || -1
        end
        f2f_courses.each do |course|
          course.occurrences.sort! do |a, b|
            a.distance <=> b.distance || (b.distance && 1) || -1
          end
        end
        f2f_courses.concat(other_courses)
      end
  end
end
