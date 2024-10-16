module Achiever
  class CourseFilter
    attr_reader :subjects, :age_groups, :search_radii

    SEARCH_RADII = [20, 30, 40, 50, 60].freeze

    # match a from date, optionally followed by a to date. if there
    # is only a from date, then it is the range beginning and ending
    # on the same day.
    DATE_RANGE_PATTERN = /^(?<from>[\d-]+)(?: to (?<to>[\d-]+))?$/

    def initialize(filter_params:, certificate: nil)
      @filter_params = filter_params
      @certificate = certificate

      @filter_params[:certificate] = @certificate if @certificate

      @subjects ||= Achiever::Course::Subject.all
      @age_groups ||= if certificate == "primary-certificate"
        Achiever::Course::AgeGroup.primary_certificate
      elsif certificate == "secondary-certificate"
        Achiever::Course::AgeGroup.secondary_certificate
      else
        Achiever::Course::AgeGroup.all
      end
      @search_radii = SEARCH_RADII
    end

    def location_based_results
      return nil unless location_search?
      return @location_search_results if defined? @location_search_results

      @location_search_results = begin
        results = Achiever::LocationCourseSearchResult.new
        results.max_radius = max_radius
        results.radius_maxed = current_radius == max_radius

        f2f_courses = courses.select { |c| !c.online_cpd && !c.remote_delivered_cpd }

        f2f_courses.sort! do |a, b|
          a.nearest_occurrence_distance <=> b.nearest_occurrence_distance || (b.nearest_occurrence_distance && 1) || -1
        end

        f2f_courses.each do |course|
          course.occurrences.sort! do |a, b|
            a.distance <=> b.distance || (b.distance && 1) || -1
          end
        end

        total_f2f_course_count = f2f_courses.size

        results_outside_max_radius = f2f_courses.select do |c|
          c.nearest_occurrence_distance.present? && c.nearest_occurrence_distance > max_radius
        end

        results_within_max_radius = f2f_courses.select do |c|
          c.nearest_occurrence_distance.present? && c.nearest_occurrence_distance <= max_radius
        end

        results_within_search_radius = if results.radius_maxed
          results_within_max_radius
        else
          results_within_max_radius.select do |c|
            c.nearest_occurrence_distance <= current_radius
          end
        end

        results.courses = results_within_search_radius
        results.courses_count = results_within_search_radius.size
        results.further_results_count = results_within_max_radius.size - results_within_search_radius.size
        results.outside_max_radius_results_count = total_f2f_course_count - results_within_max_radius.size
        results.outside_max_radius_results = results_outside_max_radius
        results.non_location_based_results_count = non_location_based_results.size
        results
      end
    end

    def non_location_based_results
      return courses unless location_search?
      return @non_location_search_results if defined? @non_location_search_results

      @non_location_search_results = courses.select { |c| c&.online_cpd || c&.remote_delivered_cpd }
    end

    def course_formats
      @course_formats ||= [{label: "Face to face", value: "face_to_face"},
        {label: "Online", value: "online"},
        {label: "Live remote", value: "remote"}]
    end

    def course_lengths
      @course_lengths ||= [
        {label: "0 - 3 Hours", value: "short_course", min: 0, max: 3.hours.to_i},
        {label: "3 - 6 Hours", value: "long_course", min: (3.hours.to_i + 1), max: 6.hours.to_i},
        {label: "1 Day", value: "day_course", min: (6.hours.to_i + 1), max: (2.day.to_i - 1)},
        {label: "2+ Days", value: "multi_day_course", min: 2.days.to_i, max: 1.year.to_i}
      ]
    end

    def course_tags
      used_subjects = all_courses.reduce([]) { |tags, c| tags + c.subjects }.uniq.sort
      @subjects.select { |_k, v| used_subjects.include?(v.to_s) }
    end

    def certificates
      @certificates ||= Programme.all.each_with_object({}) do |item, hash|
        next if !FeatureFlagService.new.flags[:alevel_programme_feature] && item.a_level?
        next unless item.include_in_filter?

        hash[item.certificate_name] = item.slug
      end
    end

    def current_certificate
      return nil if @filter_params[:certificate].blank?

      @current_certificate ||= @filter_params[:certificate]
    end

    def current_topic
      return nil if @filter_params[:topic].blank?

      @current_topic ||= @filter_params[:topic]
    end

    def current_length
      return nil if @filter_params[:course_length].blank?

      @current_length ||= @filter_params[:course_length]
    end

    def current_level
      return nil if @filter_params[:level].blank?

      @current_level ||= @filter_params[:level]
    end

    def current_location
      return nil if @filter_params[:location].blank?

      @current_location ||= @filter_params[:location]
    end

    def current_hub
      return nil if @filter_params[:hub_id].blank?

      @current_hub ||= course_occurrences.map(&:hub_name).compact.first || :no_courses
    end

    def current_date_range
      return nil if @filter_params[:date_range].blank?

      @date_range ||= @filter_params[:date_range]
    end

    def current_date_range_from
      return unless current_date_range

      matched = DATE_RANGE_PATTERN.match current_date_range
      raise ArgumentError.new("Not a valid date range: #{current_date_range}") if matched.nil?

      Date.parse(matched[:from])
    end

    def current_date_range_to
      return unless current_date_range

      matched = DATE_RANGE_PATTERN.match current_date_range
      raise ArgumentError.new("Not a valid date range: #{current_date_range}") if matched.nil?

      Date.parse(matched[:to] || matched[:from])
    end

    def current_hub_id
      return nil if @filter_params[:hub_id].blank?

      @current_hub_id ||= @filter_params[:hub_id]
    end

    def current_format
      return nil if @filter_params[:course_format].blank?

      @current_format ||= @filter_params[:course_format]
    end

    def applied_filters
      filter_strings = []
      filter_strings.push(ERB::Util.html_escape(current_level).to_s) if current_level
      filter_strings.push(ERB::Util.html_escape(current_topic).to_s) if current_topic
      filter_strings.push(ERB::Util.html_escape(current_certificate).to_s) if current_certificate && @certificate.nil?
      filter_strings.push(ERB::Util.html_escape(current_format).to_s) if current_format
      filter_strings.push(ERB::Util.html_escape(current_length).to_s) if current_length
      filter_strings.push(ERB::Util.html_escape(current_date_range).to_s) if current_date_range
      filter_strings.push(current_hub) if current_hub

      return if filter_strings.empty?

      filter_strings
    end

    def search_location_formatted_address
      return nil unless location_search?
      return @search_location_formatted_address if defined? @search_location_formatted_address

      @search_location_formatted_address ||= Geocoding.format_address(geocoded_location: geocoded_search_location)
    end

    def location_search?
      @filter_params[:location].present?
    end

    def current_radius
      return @search_radius if defined? @search_radius

      @search_radius = if @filter_params[:radius].present?
        @filter_params[:radius].to_i
      else
        40
      end
    end

    def total_results_count
      @total_results_count ||=
        location_based_results_count + non_location_based_results.size
    end

    def location_based_results_count
      @location_based_results_count ||= location_based_results.present? ? location_based_results.courses.size : 0
    end

    def geocoded_successfully?
      @geocoded_successfully ||= geocoded_search_location.present?
    end

    def includes_online_or_remote?
      return true if current_format.nil?

      current_format.include?("remote") || current_format.include?("online")
    end

    private

    def all_courses
      @all_courses ||= Achiever::Course::Template.all
    end

    def courses
      @courses ||= begin
        courses = all_courses
        courses.each do |course|
          course_occurrences.each do |course_occurrence|
            course.occurrences.push(course_occurrence) if course_occurrence.course_template_no == course.course_template_no
          end
        end

        courses.reject! { |c| c.occurrences.count.zero? } if current_hub.present? || current_date_range.present?

        filter_courses(courses)
      end
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
      course_occurrences.select do |co|
        at_hub = true
        in_range = true

        at_hub = co.hub_id == current_hub_id if current_hub_id

        unless co.online_cpd
          in_range = Date.parse(co.start_date).between?(current_date_range_from, current_date_range_to) if current_date_range
        end

        at_hub && in_range
      end
    end

    def filter_courses(courses)
      courses.select do |c|
        has_certificate = true
        has_level = true
        has_topic = true
        has_format = true
        in_length = true

        has_certificate = c.by_certificate(current_certificate) if current_certificate
        has_level = c.age_groups.any?(current_level_age_group_key) if current_level
        has_topic = c.subjects.any?(current_topic_subject_key) if current_topic
        has_format = current_format.any? { |course_format| by_course_format(c, course_format) } if current_format
        in_length = current_length.any? { |course_length| by_course_length(c, course_length) } if current_length

        has_certificate && has_level && has_topic && has_format && in_length
      end
    end

    def by_course_length(course, course_length)
      duration_value = course.duration_value.to_i
      duration_unit = Achiever::Course::DurationUnit.look_up(course.duration_unit.to_i)
      if duration_unit && duration_value
        begin
          as_time = duration_value.send(duration_unit.downcase).to_i
          length_values = course_lengths.find { _1[:value] == course_length }
          as_time.between?(length_values[:min], length_values[:max])
        rescue NoMethodError # Invalid duration unit
          false
        end
      else
        false
      end
    end

    def by_course_format(course, course_format)
      case course_format
      when "online"
        course.online_cpd
      when "remote"
        course.remote_delivered_cpd
      when "face_to_face"
        !course.online_cpd && !course.remote_delivered_cpd
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
      return nil unless location_search?
      return @geocoded_search_location if defined? @geocoded_search_location

      @geocoded_search_location = Geocoder.search(@filter_params[:location], params: {region: "GB"}).first
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

    def max_radius
      @max_radius ||= SEARCH_RADII.max
    end
  end
end
