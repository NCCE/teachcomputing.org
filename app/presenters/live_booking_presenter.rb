# text and links to help a user find and book a face-to-face or live remote course
#
# has a similar API to OnlineBookingPresenter, though a few of those instance methods aren't implemented here
class LiveBookingPresenter
  def title
    "Book this course"
  end

  def authenticated_title
    title
  end

  def no_occurrences_title
    "Further instances will be scheduled soon."
  end

  def unauthenticated_introduction
    "You need to be logged in to start the course."
  end

  def no_occurrences_introduction
    "Keep an eye on our social media for new courses announcements coming soon!"
  end

  def introduction
    "You will be taken to the STEM Learning website to see further details."
  end

  def enrolled_introduction(_course)
    raise NotImplementedError
  end

  def booking_button_title
    "Book"
  end

  def enrolled_title
    "You’re booked on this course"
  end

  def completed_title
    "You’ve completed this course"
  end

  def unauthenticated_booking_button_title
    "Login to #{title.downcase}"
  end

  def enrolled_button_title(_start_date)
    raise NotImplementedError
  end

  def completed_button_introduction
    raise NotImplementedError
  end

  def completed_button_title
    raise NotImplementedError
  end

  def activity_date(start_date, _end_date)
    return if start_date.blank?

    date = Time.zone.parse(start_date)
    date.strftime("#{date.day.ordinalize} %B %Y, %A %H:%M").to_s
  end

  def booking_path(course_template_no:, occurrence_id: nil)
    if Rails.application.config.stem_cpd_store_enabled
      path = "#{Rails.application.config.stem_cpd_store_url}/course/#{course_template_no}"
      occurrence_id.present? ? "#{path}?instance=#{occurrence_id}" : path
    else
      "#{Rails.application.config.stem_course_redirect}/cpdredirect/#{occurrence_id || course_template_no}"
    end
  end

  def address(occurrence)
    return "Live remote training" if occurrence.remote_delivered_cpd

    # Remove any blank parts of the address
    [occurrence.address_venue_name, occurrence.address_town, occurrence.address_postcode]
      .reject(&:blank?)
      .join(", ")
  end

  # @return [Boolean] true: always show this
  def show_stem_occurrence_list(_always_on)
    true
  end
end
