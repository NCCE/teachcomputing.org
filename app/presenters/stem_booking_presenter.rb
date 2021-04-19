class StemBookingPresenter < BasePresenter
  def title
    'Book this course'
  end

  def introduction
    'You will be taken to the STEM Learning website to see further details and book.'
  end

  def booking_button_title
    'Book'
  end

  def booking_path(occurence_id)
    view.stem_course_link(occurence_id)
  end

  def show_occurrence_list
    true
  end
end
