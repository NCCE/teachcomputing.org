# text and links to help a user find and enrol on a self-service online course
#
# has a similar API to LiveBookingPresenter, though a few of those instance methods aren't implemented here
class OnlineBookingPresenter
  include Rails.application.routes.url_helpers

  def title
    "Join this course"
  end

  def authenticated_title
    "Join this course"
  end

  def no_occurrences_title
    raise NotImplementedError
  end

  def unauthenticated_introduction
    "You need to be logged in to join the course."
  end

  def no_occurrence_introductions
    raise NotImplementedError
  end

  def booking_button_title
    "Join"
  end

  def enrolled_title
    "You are enrolled on this course"
  end

  def completed_title
    "You've completed this course"
  end

  # @param course_started [Boolean]
  # @return [String] a paragraph or two of HTML marked up text
  def enrolled_introduction(course_started)
    markup =
      if course_started
        <<~HTML
          <p class="govuk-body-s ncce-aside__text">
            You will be taken to the MyLearning platform for further details.
          </p>
        HTML
      else
        <<~HTML
          <p class="govuk-body-s ncce-aside__text">
            Check your email for further details about your course booking.
          </p>
          <p class="govuk-body-s ncce-aside__text">
           Not received an email confirmation? Contact <a href="mailto:info@teachcomputing.org">info@teachcomputing.org</a>.
          </p>
        HTML
      end
    markup.html_safe
  end

  def introduction
    "You will be taken to the STEM Learning website to enrol onto the online course."
  end

  def unauthenticated_booking_button_title
    "Login to join"
  end

  # @param course_started [Boolean]
  # @return [String|nil]
  def enrolled_button_title(course_started)
    course_started ? "Continue on MyLearning" : nil
  end

  def completed_button_title
    "Visit MyLearning"
  end

  def completed_button_introduction
    "You will be taken to the MyLearning platform for further details."
  end

  def booking_path(stem_course_id)
    "#{Rails.application.config.stem_course_redirect}/cpdredirect/#{stem_course_id}"
  end

  def show_stem_occurrence_list(always_on)
    !always_on
  end

  def activity_date(start_date, end_date)
    return if start_date.blank?

    parsed_start_date = Time.zone.parse(start_date)
    parsed_end_date = Time.zone.parse(end_date)
    "#{parsed_start_date.strftime("#{parsed_start_date.day.ordinalize} %B %Y")} - #{parsed_end_date.strftime("#{parsed_end_date.day.ordinalize} %B %Y")}"
  end

  def address(occurrence)
    "Online Course"
  end
end
