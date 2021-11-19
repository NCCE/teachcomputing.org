class OnlineBookingPresenter
  include Rails.application.routes.url_helpers

  def title
    'Join this course on FutureLearn'
  end

  def enrolled_title
    'You are enrolled on this course'
  end

  def completed_title
    'You’ve completed this course'
  end

  def enrolled_introduction
    'You will be taken to the FutureLearn website for further details.'
  end

  def introduction
    'You will be taken to the FutureLearn website to create an account and sign up for online courses.'
  end

  def enrolled_button_title
    'Continue course on FutureLearn'
  end

  def completed_button_title
    'View course on FutureLearn'
  end

  def completed_button_introduction
    'You will be taken to the FutureLearn website for further details.'
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
