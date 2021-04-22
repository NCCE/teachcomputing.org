class StemBookingPresenter
  include ActionView::Helpers::UrlHelper

  def title
    'Book this course'
  end

  def introduction
    'You will be taken to the STEM Learning website to see further details and book.'
  end

  def booking_button_title
    'Book'
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

  def show_occurrence_list
    true
  end
end
