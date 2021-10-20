class OnlineBookingPresenter
  include Rails.application.routes.url_helpers

  def title
    'Join this course'
  end

  def introduction
    'You will be taken to the FutureLearn website to create an account and sign up for online courses.'
  end

  def booking_path(course_id)
    futurelearn_lti_path(course_id)
  end

  def show_facilitation_periods(course, occurrences)
    course&.always_on && occurrences&.present?
  end

  def show_stem_occurrence_list
    false
  end
end
