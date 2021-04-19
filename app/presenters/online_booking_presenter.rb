class OnlineBookingPresenter < BasePresenter
  def title
    'Join this course'
  end

  def introduction
    'You will be taken to the FutureLearn website to create an account and sign up for online courses.'
  end

  def booking_path
    view.futurelearn_lti_path(view.assigns['activity'].future_learn_course_uuid)
  end

  def show_occurrence_list
    false
  end
end
