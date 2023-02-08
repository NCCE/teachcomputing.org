# TODO: should this appear differently between 20th Feb and 1st April 2023?
class OnlineBookingPresenter
  include Rails.application.routes.url_helpers

  def title
    'Join this course'
  end

  def authenticated_title
    'Join this course'
  end

  def no_occurrences_title
    raise NotImplementedError
  end

  def no_occurrence_introductions
    raise NotImplementedError
  end

  def booking_button_title
    'Book'
  end

  def enrolled_title
    'You are enrolled on this course'
  end

  def completed_title
    "You've completed this course"
  end

  def enrolled_introduction
    'You will be taken to the MyLearning website for further details.'
  end

  def introduction
    'You will be taken to the STEM Learning website to sign up for the online course.'
  end

  def unauthenticated_booking_button_title
    'Login to join'
  end

  def enrolled_button_title
    'Continue on MyLearning'
  end

  def completed_button_title
    'View course on MyLearning'
  end

  def completed_button_introduction
    'You will be taken to the MyLearning website for further details.'
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
