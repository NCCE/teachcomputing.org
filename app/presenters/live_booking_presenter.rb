# text and links to help a user find and book a face-to-face or live remote course
#
# has a similar API to OnlineBookingPresenter, though a few of those instance methods aren't implemented here
class LiveBookingPresenter
  include ActionView::Helpers::UrlHelper

  def title
    'Book this course'
  end

  def authenticated_title
    title
  end

  def no_occurrences_title
    'Dates coming soon'
  end

  def unauthenticated_introduction
    'You need to be logged in to start the course.'
  end

  def no_occurrences_introduction
    'Contact your local Computing Hub for more information'
  end

  def introduction
    'You will be taken to the STEM Learning website to see further details.'
  end

  def enrolled_introduction(_course)
    raise NotImplementedError
  end

  def booking_button_title
    'Book'
  end

  def enrolled_title
    'You’re booked on this course'
  end

  def completed_title
    'You’ve completed this course'
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

  def activity_date(start_date)
    return if start_date.blank?

    date = Time.zone.parse(start_date)
    date.strftime("#{date.day.ordinalize} %B %Y, %A %H:%M").to_s
  end

  def course_button(occurrences, course_template_no)
    return unless occurrences.blank? || occurrences.count >= 20

    link_to(
      occurrences.blank? ? 'View course' : 'See more dates',
      booking_path(course_template_no),
      class: 'govuk-button button button--full-width',
      draggable: 'false',
      target: :_blank
    )
  end

  def booking_path(occurrence_id)
    "#{ENV.fetch('STEM_OAUTH_SITE')}/cpdredirect/#{occurrence_id}"
  end

  def address(occurrence)
    return 'Live remote training' if occurrence.remote_delivered_cpd

    "#{occurrence.address_venue_name}, #{occurrence.address_town}, #{occurrence.address_postcode}"
  end

  # @return [Boolean] true: always show this
  def show_stem_occurrence_list
    true
  end
end
