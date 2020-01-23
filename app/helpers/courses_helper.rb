module CoursesHelper
  def activity_address(course)
    [
      course.address_venue_name,
      course.address_line_1,
      course.address_line_2,
      course.address_line_3,
      course.address_line_4,
      course.address_town,
    ].reject(&:blank?).join('<br>').html_safe
  end

  def activity_booking_url(booking_url)
    return if booking_url.blank?

    link_to 'Book Activity', booking_url.to_s, class: 'govuk-button'
  end

  def activity_dates(start_date, end_date)
    return if start_date.blank? || end_date.blank?

    "#{Date.parse(start_date).strftime('%-d %B')}—#{Date.parse(end_date).strftime('%-d %B %Y')}"
  end

  def activity_times(start_time, end_time)
    return if start_time.blank? || end_time.blank?

    "#{Time.zone.parse(start_time).strftime('%H:%M')} - #{Time.zone.parse(end_time).strftime('%H:%M')}"
  end

  def max_fee(fees)
    return if fees.blank?
    sorted_fees = fees.sort { |x,y| y.fee.to_f <=> x.fee.to_f }

    "£#{sorted_fees[0].fee}"
  end

  def stem_course_link(course_template_no)
    "#{ENV.fetch('STEM_OAUTH_SITE')}/cpdredirect/#{course_template_no}"
  end

  def stripped_summary(string)
    unescaped_str = CGI::unescapeHTML(string)
    strip_tags(unescaped_str)
  end

  def course_meta_icon_class(isOnlineCourse)
    isOnlineCourse ? 'icon-online' : 'icon-map-pin'
  end

  def other_courses_on_programme(course, programme, how_many = 3)
    courses = Achiever::Course::Template.all.reject { |c| c.course_template_no == course.course_template_no  }
    return courses[0...how_many] unless programme

    course_ids = programme.activities.online.zip(programme.activities.face_to_face).flatten.compact.pluck(:stem_course_id)

    courses.select do |c|
      course_ids.include?(c.course_template_no)
    end[0...how_many]
  end
end
