require "#{Rails.root}/lib/stem_course_details_scrubber.rb"

module CoursesHelper
  def activity_address(course)
    [
      course.address_venue_name,
      course.address_line_1,
      course.address_line_2,
      course.address_line_3,
      course.address_line_4,
      course.address_town
    ].reject(&:blank?).join("<br>").html_safe
  end

  def activity_booking_url(booking_url)
    return if booking_url.blank?

    link_to "Book Activity", booking_url.to_s, class: "govuk-button"
  end

  def course_start_date(start_date)
    Date.parse(start_date).strftime("%d %B %Y, %A %H:%M")
  end

  def activity_dates(start_date, end_date)
    return if start_date.blank? || end_date.blank?

    "#{Date.parse(start_date).strftime("%-d %B")}—#{Date.parse(end_date).strftime("%-d %B %Y")}"
  end

  def activity_times(start_time, end_time, dates_only = false)
    return activity_dates(start_time, end_time) if dates_only

    return if start_time.blank? || end_time.blank?

    "#{Time.zone.parse(start_time).strftime("%-d %B %H:%M")}—#{Time.zone.parse(end_time).strftime("%-d %B %Y")}"
  end

  def max_fee(fees)
    return if fees.blank?

    sorted_fees = fees.sort { |x, y| y.fee.to_f <=> x.fee.to_f }

    "£#{sorted_fees[0].fee}"
  end

  def stem_course_link(course_template_no)
    "#{Rails.application.config.stem_course_redirect}/cpdredirect/#{course_template_no}"
  end

  def stripped_summary(string)
    unescaped_str = CGI.unescapeHTML(string)
    strip_tags(unescaped_str)
  end

  def course_meta_icon_class(course)
    if course&.online_cpd
      "icon-online"
    elsif course&.remote_delivered_cpd
      "icon-remote"
    else
      "icon-map-pin"
    end
  end

  def occurrence_meta_location(occurrence)
    return "Free online course" if occurrence&.online_cpd
    return "Live remote training" if occurrence&.remote_delivered_cpd

    occurrence.address_town
  end

  # @param start_date [Date]
  def online_course_availability(start_date)
    "Available from #{start_date.strftime("%d %B %Y")}."
  end

  # @param start_date [String] parsable by Date#parse, such as '2023-04-01'
  def started?(start_date)
    Date.parse(start_date) <= Time.zone.today
  end

  def user_achievement_state(user, activity)
    achievement = Achievement.find_by(user_id: user.id, activity_id: activity&.id)

    return :not_enrolled unless achievement

    achievement.current_state.to_sym
  end

  def other_courses_on_programme(courses, course, programme, how_many = 3)
    course_ids = programme.activities.online.zip(programme.activities.face_to_face).flatten.compact.pluck(:stem_course_template_no)

    courses.select do |c|
      course_ids.include?(c.course_template_no) && course.course_template_no != c.course_template_no
    end[0...how_many]
  end

  def sanitize_stem_html(html)
    sanitize(html, scrubber: StemCourseDetailsScrubber.new)
  end

  def course_subtitle_text(course)
    type = "Face to face"
    type = "Online" if course.online_cpd
    type = "Live remote training" if course.remote_delivered_cpd

    "#{type} course"
  end

  def course_type(course)
    return "Free online course" if course.online_cpd

    remote_or_face_to_face(course)
  end

  def remote_or_face_to_face(course)
    return "Live remote training" if course.remote_delivered_cpd

    "Face to face"
  end

  def view_course_phrase(course)
    return "View dates" if course.remote_delivered_cpd || course.online_cpd

    "View locations and dates"
  end

  def clean_course_title(title)
    title.chomp(" - remote")
  end

  def filter_count(course_filter)
    filters = course_filter.applied_filters || []
    filters.count { _1 != course_filter.current_hub }
  end

  def applied_filters_string(course_filter)
    "#{pluralize(filter_count(course_filter), "filter")} applied"
  end

  def certificate_card_summary(programme)
    if programme.primary_certificate?
      "This course is part of Teach primary computing"
    elsif programme.cs_accelerator?
      "This course is part of the KS3 and GCSE Computer Science subject knowledge certificate"
    elsif programme.secondary_certificate?
      "This course is part of Teach secondary computing"
    end
  end

  def image_title(course)
    return course[:image_title] if course[:image_title].present?

    course[:title]
  end

  def course_duration_text(course)
    pluralize(course.duration_value, course.duration.downcase.chomp("s")) if course.duration.present?
  end
end
